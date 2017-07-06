class Pokemon
    attr_reader :id, :name, :type, :db
    attr_accessor :hp

    def initialize(id: nil, name: nil, type: nil, db: nil)
        @id, @name, @type, @db = id, name, type, db
        @hp = 60
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
        new_pokemon = Pokemon.new(id: row[0], name: row[1], type: row[2], db: db)

        #We're doing in a separate query since the tests are made to run before the alter
        begin
            sql_statement = "SELECT hp FROM pokemon WHERE id=#{id}"
            rows = db.execute(sql_statement)
            new_pokemon.hp = rows[0][0]
        rescue SQLite3::SQLException
        end
        new_pokemon
    end

    def alter_hp(hp, db)
        @hp = hp
        sql_statement = "UPDATE pokemon SET hp=#{hp} WHERE id=#{@id}"
        db.execute(sql_statement)
    end
    
end
