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

  describe 'friendship' do
    before :each do
      @friendA = create :user
      @friendB = create :user
    end

    it 'create a friendship' do
      @friendA.make_friendship @friendB
      
      expect(@friendA.friends.length).to eq(1)
      expect(@friendB.friends.length).to eq(1)
    end

    it 'break a friendship' do
      @friendA.make_friendship @friendB
      @friendB.break_friendship @friendA

      expect(@friendA.friends.length).to eq(0)
      expect(@friendB.friends.length).to eq(0)
    end

    it 'remove all friends' do
      friendC = create :user
      @friendA.make_friendship @friendB
      @friendA.make_friendship friendC
      @friendB.make_friendship friendC

      @friendA.remove_all_friends
      expect(@friendA.friends.length).to eq(0)
      expect(@friendB.reload.friends.length).to eq(1)
      expect(friendC.reload.friends.length).to eq(1)
    end
  end

  describe '#current_room' do
    it 'get current room' do
      room = create :room
      user = create :user, current_room_id: room.id
      expect(user.current_room).to eql(room)
    end
  end
end
