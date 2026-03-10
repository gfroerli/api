require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  class LanguageTestController < ApplicationController
    def authorize!; end

    def index
      render plain: I18n.locale
    end
  end

  def setup
    Rails.application.routes.draw do
      get 'test' => 'application_controller_test/language_test#index'
    end
  end

  test 'reading the accept language header' do
    get test_path, params: {}, env: { 'HTTP_ACCEPT_LANGUAGE' => 'da, loltheheck' }
    assert_equal 'en', response.body

    get test_path, params: {}, env: { 'HTTP_ACCEPT_LANGUAGE' => 'rm, de-CH' }
    assert_equal 'rm', response.body

    get test_path, params: {}, env: { 'HTTP_ACCEPT_LANGUAGE' => 'de-CH, en-US, fr' }
    assert_equal 'fr', response.body

    get test_path, params: {}, env: { 'HTTP_ACCEPT_LANGUAGE' => 'gsw' }
    assert_equal 'gsw', response.body
  end

  def teardown
    Rails.application.routes_reloader.reload!
  end
end
