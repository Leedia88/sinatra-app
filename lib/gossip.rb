class Gossip

    attr_accessor :author, :content, :comments

    def initialize(author, content)
        @author = author
        @content = content
        @comments = []
    end

    def save
        # headers = ["author", "content"]
        CSV.open("db/gossip.csv", "a+") do |csv|
            # csv << headers if csv.count.eql? 0
            csv << [@author, @content, @comments]
        end
        puts " >> C'est dans la boite, merci!\n\n".magenta
    end

    def self.update(author, content, index)
        gossips_array = all
        puts gossips_array
        gossips_array[index.to_i-1].content = author
        gossips_array[index.to_i-1].content = content
        CSV.open("db/gossip.csv", "wb") do |csv|
            gossips_array.each do |gossip|
                csv << [gossip.author, gossip.content, gossip.comment]
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

    def self.find(id)
        return all[id.to_i - 1]
    end

    def comment(new_comment)
    end

end
