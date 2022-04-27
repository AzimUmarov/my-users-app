require 'sqlite3'

class User
    def create(user_info)
        begin
            db = SQLite3::Database.open "app.db"
            db.execute "INSERT INTO users VALUES('#{user_info[0]}', '#{user_info[1]}', '#{user_info[2]}', '#{user_info[3]}', '#{user_info[4]}')"
        rescue SQLite3::Exception => e
            puts "Exeption occurred"
            puts e
        ensure
            id = db.last_insert_row_id
            db.close if db
            puts id
        end
    end
    def get(user_id)
        begin
            db = SQLite3::Database.open "app.db"
            user = db.execute "SELECT * FROM users WHERE rowid=#{user_id}"
        rescue SQLite3::Exception => e
            puts "Exeption occurred"
            puts e
        ensure
            db.close if db
            return createHash(user[0])
        end
    end
    def all
        begin
            db = SQLite3::Database.open "app.db"
            users = db.execute "SELECT * FROM users"
        rescue SQLite3::Exception => e
            puts "Exeption occurred"
            puts e
        ensure
            db.close if db
            hashArray = []
            for user in users
                hash = createHash(user)
                hashArray.push(hash)
            end
            return hashArray
        end
    end
    def update(user_id, attribute, value)
        begin
            db = SQLite3::Database.open "app.db"
            db.execute "UPDATE users SET #{attribute}=#{value} WHERE rowid=#{user_id}"   
        rescue SQLite3::Exception => e
            puts "Exeption occurred"
            puts e
        ensure
            db.close if db
            p "OK"
        end
    end

    def createHash(array)
        hash = Hash.new()
        hash['firstname'] = array[0]
        hash['lastname'] = array[1]
        hash['age'] = array[2]
        hash['password'] = array[3]
        hash['email'] = array[4]
        return hash
    end

    def destroy(user_id)
        begin
            db = SQLite3::Database.open "app.db"
            db.execute "DELETE FROM users WHERE rowid=#{user_id}"   
        rescue SQLite3::Exception => e
            puts "Exeption occurred"
            puts e
        ensure
            db.close if db
            p "OK"
        end
    end

    def match(email, password)
        begin
            db = SQLite3::Database.open "app.db"
            db.execute "SELECT rowid FROM users WHERE email='#{email}' AND password='#{password}'"
        rescue SQLite3::Exception => e
            puts "Exeption occurred"
            puts e
        ensure
            db.close if db
            p "OK"
        end
    end

end
user = User.new()
