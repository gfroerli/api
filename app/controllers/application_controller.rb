# frozen_string_literal: true
class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  protected

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
