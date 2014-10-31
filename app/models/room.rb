class Room
  include Mongoid::Document

  field :name, type: String
  field :genre, type: String
  field :visits, type: Integer, default: 0
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

  def self.create_from_data(data)
    data = data.with_indifferent_access
    data[:member_ids].map! do |mid|
      BSON::ObjectId.from_string mid
    end
    create data
  end
end
