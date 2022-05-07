class ApiController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authorize, except: %i[index show]

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def current_user
    @current_user ||= authenticate_token
  end

  def authorize_token
    authenticate_token || invalid_token
  end

  def authenticate_token
    authenticate_with_http_token do |token, _options|
      User.find_by(token: token) # User | nil
    end
  end

  private

  def respond_unauthorized(message)
    error = { unauthorized: message }
    render json: error, status: :unauthorized
  end
end
