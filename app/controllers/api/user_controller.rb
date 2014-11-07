class Api::UserController < BaseController
  def login
    if params[:email] and params[:password]
      user = User.where(email: params[:email]).first
      if user
        if user.valid_password? params[:password]
          success user
        else
          failure :not_acceptable, 'Incorrect password'
        end
      else
        failure :not_found, 'Could not find the specified user'
      end
    else
      failure :bad_request, 'Email and password must be provided'
    end
  end

  def add_friend
    user = User.where(email: params[:user_email]).first
    friend = User.where(email: params[:new_friend_email]).first
    if user
      user.add_friend(friend)
      success user
    else
      failure :not_found, 'User with specified email does not exist'
    end
  end

end
