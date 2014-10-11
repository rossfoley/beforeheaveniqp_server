require 'soundcloud'

class SoundcloudController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_soundcloud

  def index
    if current_user.has_soundcloud?
      @tracks = @client.get('/me/tracks')
    end
  end

  def authorize
    redirect_to @client.authorize_url(scope: 'non-expiring')
  end

  def callback
    if params[:code]
      current_user.soundcloud_access_token = @client.exchange_token(code: params[:code]).access_token
      current_user.save
      redirect_to soundcloud_url, notice: 'Successfully linked your SoundCloud account!'
    else
      redirect_to soundcloud_url, alert: 'There was an error linking your SoundCloud account!'
    end
  end

  private
  def load_soundcloud
    options = { client_id: '0cb45a6052596ee086177b11b29e8809', 
                client_secret: 'b6261a4c23a845ad6d6a1f585c1249a7',
                redirect_uri: 'http://beforeheaveniqp.herokuapp.com/soundcloud/callback' }
    options[:access_token] = current_user.soundcloud_access_token if current_user.has_soundcloud?
    @client = SoundCloud.new(options)
  end
end
