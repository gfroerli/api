# All Administrate controllers inherit from this
# `Administrate::ApplicationController`, making it the ideal place to put
# authentication logic or other before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    include ActionController::HttpAuthentication::Basic::ControllerMethods

    before_action :authenticate_admin

    def authenticate_admin
      authenticate_or_request_with_http_basic do |given_name, given_password|
        ApiConsumer.exists?(public_api_key: given_name, private_api_key: given_password)
      end
    end
  end
end
