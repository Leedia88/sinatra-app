class Comment

    attr_accessor :comment, :index

    def initialize(comment, index)
        @comment = comment
        @index = index
    end

    def save #ajoute une ligne au csv
        comment = [@index, @comment]
        CSV.open("db/comment.csv", "a+") do |csv|
            csv << comment
        end
        puts " >> C'est dans la boite, merci!\n\n".magenta
    end

    def self.all(index) #retourne un array des commentaires du potin n° index
        all_comments = []
        CSV.read("db/comment.csv").each do |comment|
            if comment[0] == index 
                all_comments << comment[1]
            end
        end
        return all_comments
    end

end