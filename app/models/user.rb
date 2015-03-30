class User
  include Mongoid::Document

  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable, :rememberable 

  ## Database authenticatable
  field :username,           type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Rememberable
  field :remember_created_at, type: Time

  ## Token authentication
  field :authentication_token

  ## Current Room
  field :current_room_id

  ## SoundCloud access token
  field :soundcloud_access_token, type: String, default: ''

  ## Friends list
  field :friend_ids, type: Array, default: []

  ## Online status
  field :is_online, type: Boolean, default: false

  ##################
  # Friend Methods #
  ##################

  def make_friendship(friend)
    self.add_friend(friend)
    friend.add_friend(self)
  end

  def break_friendship(friend)
    self.remove_friend(friend)
    friend.remove_friend(self)
  end

  def friends
    User.in(id: friend_ids)
  end

  def is_friends_with? other_user
    friend_ids.include? other_user.id
  end

  def add_friend(friend)
    unless is_friends_with? friend
      friend_ids << friend.id
      save
    end
  end

  def remove_friend(friend)
    friend_ids.delete friend.id
    save
  end

  def remove_all_friends
    friends.each do |friend|
      break_friendship friend
    end
  end

  def current_room
    Room.find current_room_id
  end

  def has_soundcloud?
    soundcloud_access_token.length > 0
  end

  # Necessary to make Devise work with Rails 4.1 and Mongoid
  def self.serialize_from_session(key, salt)
    record = to_adapter.get(key[0]["$oid"])
    record if record && record.authenticatable_salt == salt
  end
end
