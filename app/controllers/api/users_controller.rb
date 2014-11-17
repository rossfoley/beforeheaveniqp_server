class Api::UsersController < Api::BaseController
  before_filter :load_user

  def add_friend
    friend = User.where(email: params[:new_friend_email]).first
    if friend
      @user.make_friendship(friend)
      success @user
    else
      failure :not_found, 'Friend with specified email does not exist'
    end
  end

  def remove_friend
    friend = User.where(email: params[:new_friend_email]).first
    if friend
      @user.break_friendship(friend)
      success @user
    else
      failure :not_found, 'Friend with specified email does not exist'
    end
  end

  def get_friends
    success @user.friends
  end

  def update_current_room
    @user.current_room_id = params[:room_id]
    @user.save
    success @user
  end

  def get_current_room
    success user.current_room
  end

  private

  def load_user
    if params[:id]
      @user = User.find(params[:id])
      unless @user
        failure :not_found, 'User with specified ID does not exist'
      end
    end
  end
end
