class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  # GET /songs
  def index
    songs = Song.all
    song_array = []
    songs.map do | song |
      p song.song_link
      if (song.song_link.attached?)
        song_link = url_for(song.song_link)
        song_array.push({ song: song, song_link: song_link })
      else
        song_array.push({ song: song })
      end
    end
    render json: song_array, include: [:user, :tags, :favorites, :comments]
  end

  # GET /songs/1
  def show
    song = Song.find(params[:id])
    link = url_for(song.song_link)
    render json: {song: song, song_link: link}, include: [:user, :tags, :favorites, :comments], status: :success
  end

  # POST /songs
  def create
    p '*************************SONG CREATE START***************'
    song = Song.new(song_params)
    if song.save
    p '*************************SONG IS CREATED***************'
      # ? If song is created
      tagsArray = params[:tags][:tags].split(',')
      p tagsArray
      # ? use tags array to find or create new tags
      tagsArray.map do | tag | 
        p '*************************MAPPING TAGS***************'
        # ? for each tag, do song.song_tags.create with that tag_id
        newTag = Tag.find_or_create_by(name: tag)
        song.song_tags.create(tag_id: newTag.id)
      end
      render json: { song: song, song_link: url_for(song.song_link) }, include: [:user, :tags, :favorites, :comments], status: :created
    else
      render json: {error: song.errors.full_messages}, status: :not_acceptable
    end
  end

  # PATCH/PUT /songs/1
 def update
    p '************SONG UPDATE*******'
    song.song_link.attach(params[:song_link])
    if song.update(song_params)
      render json: song, status: :ok
    else
      render json: {error: song.errors.full_messages}, status: :unprocessable_entity
    end
  end

  # DELETE /songs/1
  def destroy
    song = Song.find(params[:id])
    song.destroy
    render json: {message: "Song deleted"}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      song = Song.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.require(:song).permit(:title, :user_id, :genre, :description, :number_of_plays, :song_link)
    end
end
