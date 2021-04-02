
def get_login_details
    un = validate_presence_of_input("What is your username", "You must enter a username")
    pw = validate_presence_of_input("What is your password", "You must enter a password")
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

def validate_presence_of_input(message, incorrect_message)
    input = ""
    while input == ""
        print message # "Note Title"
        input = gets.chomp
        if input == ""
            puts incorrect_message # "You must enter a title"
        end
    end
    return input
end