class HomeController < ActionController::API
  def index
    render plain: 'This is the gfrörli API, see https://gfrör.li/about for more information.'
  end
end
