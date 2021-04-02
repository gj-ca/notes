require 'csv'
require_relative "classes/Note"
require_relative "methods"
quit = false
users = []
CSV.open("notes.csv") do |csv|
    csv.each do |note|
        begin
            Note.new(note[0], note[1], note[2], note[3])
        rescue => exception
            puts "Bad Data in CSV, skipping to next"
        end
    end
end

# Class Method
# Note.output_all_notes_titles()

# # Instance Method
# note1 = Note.new("user1", "desc1", "cat1", "user1")
# note2 = Note.new("user2", "desc2", "cat2", "user2")
# note3 = Note.new("user3", "desc3", "cat3", "user3")
# note2.output_info()


# user = {username: "user1", password: "password1"} # DEBUG ONLY


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
    system 'clear'
    puts "what would you like to do?"
    puts "options: create, read, edit, delete, quit"
    input = gets.chomp.downcase
    case input
    when "quit"
        quit = true
    when "create"
        # Creating a note hash, then pushing to our array of notes. 
        # Replaced with a class
        # notes.push({
        #     title: note[:title],
        #     description: note[:description],
        #     category: note[:category],
        #     owner: note[:owner]
        # })
        # Creating a new instance of a note, automatically adds to @@notes inside the Note
        Note.new(
            validate_presence_of_input("Note Title: ", "You must enter a title"), 
            description: validate_presence_of_input("Note Description: ", "You must enter a description"), 
            category: validate_presence_of_input("Note Category: ", "You must enter a category"), 
            owner: user[:username]
        )
        puts "Note has been created!"
        puts "Press enter to continue..."
        gets.chomp
    when "read"
        # 1. Output all notes by title
        Note.output_all_notes_titles()

        #2. USer enters title of note they wish to view
        input = validate_presence_of_input("Which note do you want to view?", "You must enter a title")

        #3. Find note
        # Finding the note out of our class variable @@notes when given the title of the note we are looking for
        note = Note.find_note(input)

        #4. Show contents of note
        note.output_info

        puts "Press enter to continue..."
        gets.chomp

    when "edit"
        # 1. list out all the notes by title
        Note.output_all_notes_titles()
        # 2. user enters title of which note to edit
        input = validate_presence_of_input("Which note do you want to edit?", "You must enter a title")

        # 3. show contents of note
        # Finding the note out of our class variable @@notes when given the title of the note we are looking for
        note = Note.find_note(input)

        # 4. get input for title, desc, category
        new_note = {
            owner: user[:username]
        }
        
        # 5. update the note 
        # Using our instance method edit_note to update the existing note with new information
        note.edit_note(
            validate_presence_of_input("Note Title: ", "You must enter a title"), 
            validate_presence_of_input("Note Description: ", "You must enter a description"), 
            validate_presence_of_input("Note Category: ", "You must enter a category"), 
        )
        puts "Note has been updated!"
        puts "Press enter to continue..."
        gets.chomp
    when "delete"
        
        # 1. list out all the notes by title
        Note.output_all_notes_titles()
        
        # 2. user enters title of which note to edit
        input = validate_presence_of_input("Which note do you want to edit?", "You must enter a title")

        # 3. Find Note
        # Finding the note out of our class variable @@notes when given the title of the note we are looking for
        note = Note.find_note(input) 

        # 4. Confirm choice
        puts "Is this the note you wish to delete? y/n"
        note.output_info
        input = gets.chomp

        # 5. Remove Note
        if input == "y"
            Note.remove_note(note)
            puts "Note successfully removed"
        else 
            puts "Returning to main menu..."
        end

        puts "Press enter to continue..."
        gets.chomp
    else
        puts "Incorrect Option, try again."
    end
end

Note.write_to_notes_file()