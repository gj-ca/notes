require 'csv'
quit = false
users = CSV.open("users.csv", "a+")
user = {}

def get_login_details
    puts "What is your username?"
    un = gets.chomp
    puts "What is your password?"
    pw = gets.chomp
    return un, pw
    # ["foo", "bar"]
end

def find_user?(username)
    CSV.open("users.csv", "a+")  do |csv|
        csv.each do |line|
            if line[0] == username
                return line
            end
        end
        return false
    end
end

def append_to_csv(username, password)
    CSV.open("users.csv", "a") do |csv|
        csv << [username, password]
    end
end

until quit
    until user != {}
        puts "options: [login, signup]"
        input = gets.chomp
        if input == "signup"
            username, password = get_login_details()
            username_is_taken = find_user?(username)
            if username_is_taken == false
                append_to_csv(username, password)
                user[:username] = username
                user[:password] = password
            end
        elsif input == "login"
            username, password = get_login_details()
            line = find_user?(username)
            if line[1] == password
                user[:username] = line[0]
                user[:password] = line[1]
                puts "You are logged in"
            end
            if user == {}
                puts "Incorrect Information, try again"
            end
        end
    end

    puts "what would you like to do?"
    puts "options: quit"
    input = gets.chomp
    if input == "quit"
        quit = true
    end
end

