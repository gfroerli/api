class ApplicationController < ActionController::API
  def root
    render plain: 'This is the coredump water sensor api. See https://coredump.ch for contact information.'
  end
end
