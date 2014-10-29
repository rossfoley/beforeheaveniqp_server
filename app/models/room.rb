class Room
  include Mongoid::Document

  field :name, type: String
  field :genre, type: String
  field :visits, type: Integer
  field :member_ids, type: Array, default: []

  ################
  # Band Members #
  ################

  def add_band_member(user)
    member_ids << user.id
    save
  end

  def remove_band_member(user)
    member_ids.delete user.id
    save
  end

  def band_members
    User.in(id: member_ids)
  end
end