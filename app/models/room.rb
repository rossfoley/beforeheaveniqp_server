class Room
  include Mongoid::Document
  include Mongoid::Search

  field :name, type: String
  field :genre, type: String
  field :visits, type: Integer, default: 0
  field :member_ids, type: Array, default: []
  field :unity_data
  field :playlist
  field :started_at, type: DateTime

  search_in :name, :genre

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

  #######################
  # SoundCloud Playlist #
  #######################
  
  def initialize_playlist
    owner = band_members.first
    if owner.has_soundcloud?
      client = SoundCloud.new(access_token: owner.soundcloud_access_token)
      playlists = client.get('/me/playlists')
      byebug
      if playlists.length > 0
        self.playlist = playlists[0]
        self.started_at = DateTime.now
        save
      end
    end
  end

  def current_song
    if playlist
      elapsed_ms = ((DateTime.now - started_at) * 24 * 60 * 60 * 1000).to_i
      playlist_location = elapsed_ms % playlist['duration']
      song = playlist['tracks'].find do |track|
        if playlist_location > track['duration']
          playlist_location -= track['duration']
          false
        else
          true
        end
      end
      "#{song['stream_url']}?client_id=0cb45a6052596ee086177b11b29e8809"
    else
      ''
    end
  end
end
