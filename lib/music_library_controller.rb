class MusicLibraryController
  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
  end

  def call
    input = ""

    while input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"

      input = gets.strip

      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end
    end
  end

  def list_songs
    Song.all.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
      puts "#{i}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
    end
  end

  def list_artists
    Artist.all.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |a, i|
      puts "#{i}. #{a.name}"
    end
  end

  def list_genres
    Genre.all.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |g, i|
      puts "#{i}. #{g.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip

    if artist = Artist.find_by_name(input)
      artist.songs.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
        puts "#{i}. #{s.name} - #{s.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip

    if genre = Genre.find_by_name(input)
      genre.songs.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
        puts "#{i}. #{s.artist.name} - #{s.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"

    input = gets.strip.to_i
    if (1..Song.all.length).include?(input)
      song = Song.all.sort{ |a, b| a.name <=> b.name }[input - 1]
    end

    puts "Playing #{song.name} by #{song.artist.name}" if song
  end
end

# class MusicLibraryController
#
#   def initialize(path = "./db/mp3s")
#     MusicImporter.new(path).import
#   end
#
#   def call
#
#     input=nil
#     loop do
#       prompt_for_input
#       input=gets.strip
#       case input
#
#       when "list songs"
#       	list_songs
#
#       when "list artists"
#         Artist.all.each_with_index{|artist| puts "#{artist.name}"}
#
#       when "list genres"
#         Genre.all.each_with_index{|genre| puts "#{genre.name}"}
#
#       when "play song"
#         play_song
#
#       when "list artist"
#         song_by_artist
#
#       when "list genre"
#         song_by_genre
#
#       when "exit"
#         break
#
#       else
#         invalid_input
#
#       end
#     end
#   end
#
#   def list_songs
# 	s = Song.all.sort_by {|f| f.artist.name}
# 	s.each_with_index do |f, index|
# 		puts "#{index + 1}. #{f.artist.name} - #{f.name} - #{f.genre.name}"
# 	end
#   end
#
#   def play_song
#     input = gets.strip.to_i - 1
#     s = Song.all.sort_by {|f| f.artist.name}
#     puts "Playing #{s[input].artist.name} - #{s[input].name} - #{s[input].genre.name}"
#   end
#
#   def invalid_input
#   	  puts "invalid input, Please enter:"
#       call
#   end
#
#   def song_by_artist
#   	puts "Pick an artist"
#     input=gets.strip
#
#     Artist.find_by_name(input).songs.each do |song|
#     	puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
#     end
#
#   end
#
#   def song_by_genre
#   	puts "Pick a genre"
#     input=gets.strip
#
#     Genre.find_by_name(input).songs.each do |song|
#     	puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
#     end
#
#   end
#
#   def prompt_for_input
#   	  puts "Please make a Choice"
#       puts "list songs"
#       puts "list artists"
#       puts "list genres"
#       puts "play a song"
#       puts "list artist"
#       puts "list genre"
#       puts "To exit, please type exit"
#   end
#
# end