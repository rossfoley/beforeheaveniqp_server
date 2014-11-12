require 'rails_helper'

RSpec.describe Room, :type => :model do
  describe 'band members' do
    before :each do
      @user = create :user
      @room = create :room, member_ids: [@user.id]
    end

    it 'contains a list of band members' do
      expect(@room.band_members).to_not be_empty
    end

    it 'can add new band members' do
      @user2 = create :user
      @room.add_band_member @user2
      expect(@room.band_members.length).to eq(2)
    end

    it 'can remove band members' do
      @room.remove_band_member @user
      expect(@room.band_members).to be_empty
    end

    it 'can determine if a user is a band member' do
      expect(@room.is_band_member? @user).to be true
    end

    it 'will only add unique band members' do
      @room.add_band_member @user
      @room.add_band_member @user
      expect(@room.band_members.length).to eq(1)
    end
  end

  describe 'SoundCloud playlists' do
    before :each do
      playlist = {'duration' => 20000, 
                  'tracks' => [{'duration' => 11000, 'stream_url' => 'test1'},
                               {'duration' => 9000, 'stream_url' => 'test2'}]}
      @room = create :room, playlist: playlist
    end

    it 'can determine the current song playing' do
      @room.started_at = DateTime.now
      expect(@room.current_song).to_not be_nil
      expect(@room.current_song[:song]['stream_url']).to eq('test1')

      @room.started_at = 13.seconds.ago
      expect(@room.current_song[:song]['stream_url']).to eq('test2')
    end
  end
end
