require 'pry'

class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
    self
  end

  def self.create
    self.new.save
  end

  def self.new_by_name(name)
    new_song = self.new
    new_song.name = name
    new_song
  end

  def self.create_by_name(name)
    new_song = self.new.save
    new_song.name = name
    new_song
  end

  def self.find_by_name(name)
    self.all.find { |song| song.name == name  }
  end

  def self.find_or_create_by_name(name)
    song = self.find_by_name(name)
    if song.nil?
      song = self.create_by_name(name)
    end
    song
  end

  def self.alphabetical
    songs = self.all.collect{ |song| song.name }
    songs.sort!

    sorted_songs = []
    songs.each do |name|
      self.all.collect do |song|
        if song.name == name
          sorted_songs << song
        end
      end
    end
    sorted_songs
  end

  def self.new_from_filename(filename)
    song_and_artist = filename.split(" - ")
    artist_name = song_and_artist[0]
    song_name = song_and_artist[1]
    if song_name.include?(".mp3")
      song_name.slice!(".mp3")
    end

    song = self.find_or_create_by_name(song_name)
    song.artist_name = artist_name
    song
  end

  def self.create_from_filename(name)
    self.new_from_filename(name)
  end

  def self.destroy_all
    self.all.clear
  end
end
