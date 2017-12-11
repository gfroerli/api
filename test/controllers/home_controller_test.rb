# frozen_string_literal: true
require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get root_url
    assert_response :success
  end

  test 'should get ndex' do
    get 'sdfsdfsdf'
    assert_response :success
  end
end
