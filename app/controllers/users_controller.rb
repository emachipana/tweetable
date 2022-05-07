class UsersController < ApplicationController
  def show
    if User.find_by(id: params[:id])
      @user = User.find(params[:id])
    else
      redirect_to root_path, status: :not_found
    end
  end
end
