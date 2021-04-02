class Note
    @@notes = []
    attr_reader :title, :description, :category, :owner
    def initialize(title, description, category, owner)
        if title.nil? || description.nil? || category.nil? || owner.nil?
            raise StandardError
        end
        @title = title
        @description = description
        @category = category
        @owner = owner
        @@notes.push(self)
    end

    def self.get_notes
        return @@notes
    end

    def self.output_all_notes_titles
        @@notes.each do |note|
            puts "Title: #{note.title}"
        end
    end

    def self.write_to_notes_file
        CSV.open("notes.csv", "w") do |csv|
            @@notes.each do |note|
                # csv << [note[:title],note[:description],note[:category],note[:owner]]
                csv << [note.title,note.description,note.category,note.owner]
            end
        end
    end

    def self.find_note(title)
        # Iterate over our @@notes and find the index of the element that has that title
        index = @@notes.find_index {|note| note.title == input }
        # Return the correct note
        return @@notes[index]
    end

    def self.remove_note(note)
        index = @@notes.find_index { |element| element == note }
        @@notes.delete_at(index)
    end
    # to_s
    def output_info
        puts "Title: #{@title}, Description: #{@description}, Category: #{@category}"
    end

    def edit_note(title, description, category)
        @title = title
        @description = description
        @category = category
    end
end


# Note.new("title1", "description1", "cat1", user[:username])

