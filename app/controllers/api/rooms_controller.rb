class Api::RoomsController < Api::BaseController
  def index
    success Room.all.to_a
  end

  def show
    success Room.find(params[:id])
  end

  def update
    if params[:room_data].is_a? String
      room_data = JSON.parse params[:room_data]
    else
      room_data = params.require(:room_data).permit! :name, :genre, :unity_data
    end
    room = Room.find(params[:id])
    room.update_attributes room_data
    success room
  end

  def create
    if params[:room_data].is_a? String
      room_data = JSON.parse params[:room_data]
    else
      room_data = params.require(:room_data).permit!
    end
    room = Room.create(room_data)
    room.add_band_member current_user
    room.initialize_playlist
    success room
  end

  def destroy
    room = Room.find(params[:id])
    if room.destroy
      success
    end
  end

  def search
    success Room.full_text_search(params[:search_term]).to_a
  end

  def current_song
    room = Room.find(params[:id])
    success room.current_song
  end

  def add_band_member
    room = Room.find(params[:id])
    user = User.where(email: params[:new_member_email]).first
    if room
      if user
        room.add_band_member(user)
        success room
      else
        failure :not_found, 'User with specified email does not exist'
      end
    else
      failure :precondition_failed, 'specified room does not exist'
    end
  end
end
