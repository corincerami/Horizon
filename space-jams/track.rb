class Track
  attr_reader :id, :album_id, :title, :track_number, :duration_ms

  def initialize(id, album_id, title, track_number, duration_ms)
    @id = id
    @album_id = album_id
    @title = title
    @track_number = track_number
    @duration_ms = duration_ms
  end
end
