class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def index
  end

  def show
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      render json: @user, status: :created
    else
      render json: { error: 'failed to create user' }, status: :not_acceptable
    end
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :password_digest, :user_type, :avatar)
  end

end
