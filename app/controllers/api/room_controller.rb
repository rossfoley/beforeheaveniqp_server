class Api::RoomController < Api::BaseController
  def index
    success Room.all.to_a
  end
end
