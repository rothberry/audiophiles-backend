class ApplicationController < ActionController::API
 
  def issue_token(user)
    JWT.encode({user_id: user.id}, 't0k3n', 'HS256')
  end

  def current_user
    @user ||= User.find_by(id: user_id)
  end

  def token
    if request.headers['Authorization']
      return request.headers['Authorization'].split(' ')[1]
    end
  end

  def decoded_token
    begin
      JWT.decode(token, 't0k3n', true, algorithm: 'HS256')
    rescue JWT::DecodeError
      [{}]
    end
  end

  def user_id
    decoded_token.first['user_id']
  end

  def logged_in?
    !!current_user
  end

  def reload_image(user)
    user.img_url = user.image_link.service_url
    user.save
  end
  
end
