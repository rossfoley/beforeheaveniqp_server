class Api::UsersController < Api::BaseController
  def add_friend
    user = User.find(params[:id])
    friend = User.where(email: params[:new_friend_email]).first
    if user
      user.add_friend(friend)
      success user
    else
      failure :not_found, 'User with specified email does not exist'
    end
  end
end
