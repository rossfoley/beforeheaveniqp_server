class Api::RoomController < Api::BaseController
  def index
    success Room.all.to_a
  end

  def create
    if params[:room_data].is_a? String
      room_data = JSON.parse params[:room_data]
    else
      room_data = params.require(:room_data).permit!
    end
    room = Room.create_from_data(room_data)
    success room
  end
end
