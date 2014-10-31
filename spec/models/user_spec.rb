require 'rails_helper'

RSpec.describe User, :type => :model do
  describe '#has_soundcloud?' do
    it 'correctly determines if the user has linked their SoundCloud account' do
      user = create :user
      user.soundcloud_access_token = 'soundcloud_token'
      expect(user.has_soundcloud?).to be true
    end
  end
  
  describe '#serialize_from_session' do
    it 'finds the correct record' do
      user = create :user
      key = [{'$oid' => user.id.to_s}]
      salt = user.authenticatable_salt
      expect(User.serialize_from_session(key, salt)).to eq(user)
    end
  end  
end
