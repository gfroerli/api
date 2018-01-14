
# frozen_string_literal: true

class HomeController < ActionController::API
  def index
    render plain: 'This is the coredump water sensor api. See https://coredump.ch for contact information.'
  end
end
