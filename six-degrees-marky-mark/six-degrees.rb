require "pg"
require "pry"

if ARGV.length != 1
  puts "usage: #{__FILE__} \"<actor name>\""
  exit(1)
end

target_actor = ARGV[0]

def db_connection
  begin
    connection = PG.connect(dbname: 'movies')

    yield(connection)
  ensure
    connection.close
  end
end

def select_from_db(query)
  result = db_connection do |conn|
    conn.exec(query)
  end
  result.to_a
end

class Actor
  def initialize
    @open_routes = Array.new
    @closed_routes = Array.new
  end


end
