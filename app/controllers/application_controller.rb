# frozen_string_literal: true
class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authorize!

  protected

  def authorize!
    return if controller_name == 'home' && action_name == 'index'

    if %w(measurements sensors sponsors).include?(controller_name) && %w(index show).include?(action_name)
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
      ApiConsumer.exists?(public_api_key: token)
    end
  end
end
