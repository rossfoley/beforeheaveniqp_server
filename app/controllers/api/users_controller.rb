class Api::UsersController < Api::BaseController
  def add_friend
    user = User.find(params[:id])
    friend = User.where(email: params[:new_friend_email]).first
    if user
      user.make_friendship(friend)
      success user
    else
      failure :not_found, 'User with specified email does not exist'
    end
  end

  def remove_friend
    user = User.find(params[:id])
    friend = User.where(email: params[:new_friend_email]).first
    if user
      user.break_friendship(friend)
      success user
    else
      failure :not_found, 'User with specified email does not exist'
    end
  end

  def get_friends
    user = User.find(params[:id])
    if user
      success user.friends
    else
      failure :not_found, 'User with specified id does not exist'
    end
  end

  def update_current_room
    if params[:user_data].is_a? String
      user_data = JSON.parse params[:user_data]
    else
      user_data = params.require(:user_data).permit! :current_room_id
    end
    user = User.find(params[:id])
    user.update_attributes user_data
    success user
  end

  def get_current_room
    user = User.find(params[:id])
    if user
      success user.current_room
    else
      failure :not_found, 'User with specified id does not exist'
    end
  end
end
