class DBConnection

  def self.connect(db_name)
    begin
      connection = PG.connect(dbname: db_name)

      yield(connection)
    ensure
      connection.close
    end
  end
end
