class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authorize!

  private

  def authorize!
    return if controller_name == 'home' && action_name == 'index'

    if publicly_accessible_controller_actions[controller_name]&.include?(action_name)
      require_public_access!
    else
      require_private_access!
    end
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

  def request_http_token_authentication(realm = 'Application', _message = nil)
    headers['WWW-Authenticate'] = %(Token realm="#{realm.delete('"')}")
    render json: { error: 'HTTP Token: Access denied.' }, status: :unauthorized
  end

  def publicly_accessible_controller_actions
    {
      'measurements' => %w[index show aggregated],
      'sensors' => %w[index show],
      'sponsors' => %w[index show],
      'sponsor_images' => %w[show]
    }
  end
end
