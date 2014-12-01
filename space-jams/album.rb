class Album
  attr_reader :id, :title, :artists, :duration_min
  attr_accessor :tracks

  def initialize(id, title, artists)
    @id = id
    @title = title
    @artists = artists
    @tracks = []
  end

  def duration_min
    @duration_min = 0.0
    @tracks.each do |track|
      @duration_min += track[:duration_ms].to_f / 60000
    end
    @duration_min
  end

  def summary
    @summary = "Name: #{@title}\nArtist(s): #{@artists}\nDuration (min.): #{self.duration_min.round(2)}\nTracks:\n"
  end

end
