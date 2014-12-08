class Api::UsersController < Api::BaseController
  before_filter :load_user

  def add_friend
    friend = User.where(username: params[:new_friend_username]).first
    if friend
      @user.make_friendship(friend)
      success @user
    else
      failure :not_found, 'Friend with specified username does not exist'
    end
  end

  def remove_friend
    friend = User.where(username: params[:new_friend_username]).first
    if friend
      @user.break_friendship(friend)
      success @user
    else
      failure :not_found, 'Friend with specified username does not exist'
    end
  end

  def get_friends
    success @user.friends
  end

  def update_current_room
    room = Room.find(params[:room_id])
    if room
      room.visits += 1
      room.save

      @user.current_room_id = params[:room_id]
      @user.save
      success @user
    end
  end

  def get_current_room
    success @user.current_room
  end
  
  def update_is_online
    @user.is_online = params[:is_online]
    @user.save
    success @user
  end
  
  def get_is_online
    success @user.is_online
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
