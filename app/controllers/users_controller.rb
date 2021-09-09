class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  # skip_before_action :authorized, only: [:create, :index]
  
  def index
    users = User.all
    render json: users, include: [:active_relationships,:passive_relationships]
  end

  def show
    user = User.find_by(id: params[:id])
    followed_array = user.active_relationships.map(&:followed_id)
    follower_array = user.passive_relationships.map(&:follower_id)
    user.img_url = user.image_link.service_url
    render json: {user: user, followed: followed_array, follower: follower_array} 
  end

  def create
    p '#########################################'
    user = User.new(user_params)
    if user.save
      token = issue_token(user)
      p user
      render json: {user: user, jwt: token}, status: :created
    else
      render json: {error: user.errors.full_messages}, status: :not_acceptable
    end
  end

  def update
    p '************UPDATE USER************'
    # user = User.find_by(id: params[:id])
    user = current_user
    p '************PARAMS************'
    p params
    p '************USER************'
    p user
    p '************USER PARAMS************'
    p user_params = {
      id: params[:id],
      username: params[:username],
      name: params[:name],
      # password: params[:password],
      location: params[:location],
      bio: params[:bio],
      img_url: params[:img_url],
      facebook_url: params[:facebook_url],
      twitter_url: params[:twitter_url],
      soundcloud_url: params[:soundcloud_url]
    }
    if user.update(user_params)
      render json: user, status: :ok
    else
      render json: {error: user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    p '************DELETE USER************'
    user = User.find_by(id: params[:id])
    user.destroy
    render json: {message: "User Deleted"}
  end

  private

  def set_user
    user = User.find_by(id: params[:id])
  end
  
  def user_params
    params.require(:user).permit(:username, :password, :name, :location, :bio, :soundcloud_url, :img_url, :twitter_url, :facebook_url, :image_link)
    # params.permit!
  end
  
end
