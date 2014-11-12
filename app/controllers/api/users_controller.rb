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
end
