class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authorize!

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  private

  def authorize!
    return if controller_name == 'home' && action_name == 'index'

    # TODO: This is cheap, reorganize properly
    if %w[measurements sensors sponsors].include?(controller_name) && %w[index show aggregated daily_temperatures sponsor].include?(action_name)
      return require_public_access!
    end

    require_private_access!
  end

  def require_private_access!
    authenticate_or_request_with_http_token do |token, _options|
      ApiConsumer.exists?(private_api_key: token)
    end
  end

  def require_public_access!
    authenticate_or_request_with_http_token do |token, _options|
      ApiConsumer.exists?(public_api_key: token) || ApiConsumer.exists?(private_api_key: token)
    end
  end

  # We respond with JSON instead of plaintext like Rails would per default
  # to signal that authentication is required
  def request_http_token_authentication(realm = 'Application', _message = nil)
    headers['WWW-Authenticate'] = %(Token realm="#{realm.delete('"')}")
    render json: { error: 'HTTP Token: Access denied.' }, status: :unauthorized
  end

  def handle_not_found(e)
    render json: { error: e.to_s }, status: :not_found
  end
end
