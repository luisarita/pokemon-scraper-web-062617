class Pokemon
    attr_reader :id, :name, :type, :db
    def initialize(id: nil, name: nil, type: nil, db: nil)
        @id, @name, @type, @db = id, name, type, db
    end
    def self.save(name, type, db)
        #pokemon = Pokemon.new(row[0], row[1], @db)
        sql_statement = "INSERT INTO pokemon (name, type) VALUES (?, ?)"
        db.execute(sql_statement, name, type)
    end
    def self.find(id, db)
        sql_statement = "SELECT id, name, type FROM pokemon WHERE id=#{id}"
        rows = db.execute(sql_statement)
        row = rows[0]
        Pokemon.new(id: row[0], name: row[1], type: row[2], db: db)
    end
    
end
