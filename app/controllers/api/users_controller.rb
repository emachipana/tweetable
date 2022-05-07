module Api
  class UsersController < ApiController
    before_action :set_user, only: %i[ show update ]

    def show
      render json: @user, status: :ok
    end

    def update
      if @user.update(user_params)
        render json: @user, status: :accepted
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :name, :avatar)
    end
  end
end