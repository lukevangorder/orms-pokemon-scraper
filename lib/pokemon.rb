class Pokemon
    attr_reader :name, :type, :db, :id
    def initialize(name:, type:, db:, id:nil)
        @name = name
        @type = type
        @db = db
        @id = id
    end
    def self.save(name, type, database)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        SQL
        database.execute(sql, [name, type])
        @id = database.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end
    def self.find(id_number, database)
        sql = <<-SQL
            SELECT *
            FROM pokemon
            WHERE id = #{id_number}
        SQL
        array = database.execute(sql)[0]
        found = self.new(name: array[1], type: array[2], db: database, id: id_number)
        return found
    end
end
