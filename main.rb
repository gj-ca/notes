require 'csv'
# psuedocode
# applications features - 
    # - users - can login
            #- can signup
            # can logout
    # - notes 
        # - create note
        # - edit notes
        # - delete note


quit = false
# while quit == false
# while quit == false
#     input = gets.chomp
#     if input == "quit"
#         quit = true
#     end
# end
users_array = []
user = {}

until quit
    logged_in = false
    until logged_in
        puts "options: [login, signup]"
        input = gets.chomp
        if input == "signup"
            puts "What is your username?"
            username = gets.chomp
            puts "What is your password?"
            password = gets.chomp
            CSV.open("users.csv", "a+")  do |csv|
                username_is_taken = false
                csv.each do |line|
                    if line[0] == username
                        puts "that is a taken username"
                        username_is_taken = true    
                    end
                end
                if username_is_taken == false
                    csv << [username,password]
                    logged_in = true
                    user[:username] = username
                    user[:password] = password
                end
            end
        elsif input == "login"
            successful_login = false
            puts "What is your username"
            username = gets.chomp
            puts "What is your password"
            password = gets.chomp
            CSV.open("users.csv", "r")  do |csv|
                csv.each do |line|
                    if line[0] == username
                        if line[1] == password
                            successful_login = true
                            logged_in = true
                            user[:username] = line[0]
                            user[:password] = line[1]
                            puts "You are logged in"
                        end
                    end
                end
            end
            if successful_login == false
                puts "Incorrect Information, try again"
            end
        end
    end
    p user

    puts "what would you like to do?"
    puts "options: quit"
    input = gets.chomp
    if input == "quit"
        quit = true
    end
end

