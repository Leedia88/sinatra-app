class Gossip

    attr_accessor :author, :content

    def initialize(author, content)
        @author = author
        @content = content
    end

    def save #ajoute une ligne au csv"
        gossip = [@author, @content]
        CSV.open("db/gossip.csv", "a+") do |csv|
            csv << gossip
        end
        index = CSV.read("db/gossip.csv").size
        puts index
        comm = Comment.new(" ", index).save
        puts " >> C'est dans la boite, merci!\n\n".magenta
    end

    def self.update(author, content, index) #change le contenu de la ligne
        gossips_array = all
        puts gossips_array
        gossips_array[index.to_i-1].content = author
        gossips_array[index.to_i-1].content = content
        CSV.open("db/gossip.csv", "wb") do |csv|
            gossips_array.each do |gossip|
                csv << [gossip.author, gossip.content]
            end
        end
    end


    def self.all #renvoit un array de gossips
        all_gossips = []
        CSV.read("db/gossip.csv").each do |csv_line|
            all_gossips << Gossip.new(csv_line[0], csv_line[1])
        end
        return all_gossips
    end

    def self.find(id) #renvoit un gossip
        return all[id.to_i - 1]
    end

end
