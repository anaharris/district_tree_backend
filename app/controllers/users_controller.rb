class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def profile
    token = request.headers["Authentication"].split(" ")[1]
    payload = decode(token)
    user_id = payload["user_id"]
    render json: { user: User.find(user_id) }, status: :accepted
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      render json: { user: UserSerializer.new(@user) }, status: :created
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
    params.require(:user).permit(:name, :username, :password, :user_type, :avatar)
  end

end
