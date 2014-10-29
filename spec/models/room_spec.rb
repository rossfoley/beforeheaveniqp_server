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
  end
end