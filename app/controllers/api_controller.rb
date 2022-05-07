class ApiController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  
  before_action :authorize, except: %i[index show]

  # def index; end
  # def show; end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

  def current_user
    @current_user ||= authenticate
  end

  def not_found(error)
    render json: { errors: error.message }, status: :not_found
  end

  def authorize
    authenticate || invalid_token
  end

  def authenticate
    authenticate_with_http_token do |token, _options|
      User.find_by(token: token)
    end
  end

  def not_authorized
    render json: { errors: "Not authorized" }, status: :unauthorized
  end

  def invalid_token
    render json: { errors: "Invalid token, Please check your credentials." }, status: :unauthorized
  end
end
