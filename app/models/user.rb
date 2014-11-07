class User
  include Mongoid::Document

  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Token authentication
  field :authentication_token

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## SoundCloud access token
  field :soundcloud_access_token, type: String, default: ''

  ## Friends list
  field :friend_ids, type: Array, default: []

  ##################
  ## Friends List ##
  ##################

  def add_friend(user)
    friend_ids << user.id
    save
  end

  def remove_friend(user)
    friend_ids.delete user.id
    save
  end

  def friends
    User.in(id: member_ids)
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
