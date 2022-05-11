class Api::V1::AuthController < ApplicationController
#   skip_before_action :authorized, only: [:create, :show]

  # * For the Initial Login Process
  def create
    p "*********************AUTH LOGIN*****************************"
    user = User.find_by(username: params[:username])
    p user
    if user && user.authenticate(params[:password])
      token = issue_token(user)
      render json: {user: user, jwt: token}, status: :accepted
    else 
      render json: {error: 'Invalid username or password'}, status: :unauthorized
    end
  end
  
  # * For finding current user on refresh or similar
  def show
    p "***********************AUTH SHOW**************************"
    if logged_in?
      render json: {user: @user}, include: [:active_relationships,:passive_relationships], status: :accepted
    else
      render json: {error: 'Invalid Token'}, status: :unauthorized
    end
  end

  private

  def user_login_params
    params.require(:user).permit(:username, :password)
  end
end
