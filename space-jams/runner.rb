require 'csv'
require_relative 'album'
require_relative 'track'

albums = []

CSV.foreach('space_jams.csv', headers: true, header_converters: :symbol) do |row|
  track = Track.new(row[:track_id], row[:album_id], row[:title], row[:track_number], row[:duration_ms])
  album = albums.find { |a| a.id == track.album_id }

  # if the album hasn't been added to the albums array yet, add it
  if album.nil?
    album = Album.new(track.album_id, row[:album_name], row[:artists])
    albums << album
  end

  # add the track to the album's @tracks instance variable
  album.tracks << track
end

# print out the summary for each album
albums.each do |album|
  puts album.summary
end
