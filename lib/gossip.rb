require 'csv'
class Gossip

  attr_accessor :author, :content

  def initialize(author,content)
    @author = author
    @content = content
  end

  def save                                              #Avec le block, pour chaque author et content on les rentre dans le CSV
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [author, content]
    end
  end

  def self.all                        #Je créé un array vide
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|      # Pour chaque ligne de mon CSV, je les rentre dans array all_gossips
      all_gossips << Gossip.new(csv_line[0], csv_line[1]) # Je rentre chacune de mes lignes dans mon array valeur par valeur.
    end
      return all_gossips        #Je retourne mon array all_gossips
  end

  def self.find(id)
    new_id = id.to_i            #Obligé de le passer en integer sinon on ne peut pas décrémenter.
    new_id -= 1         #Je décrémente ma varible new_id
    CSV.foreach("./db/gossip.csv").with_index do |row, i|         # Block pour chaque ligne de mon csv par index
      if i == new_id                                              # Je teste si l'index est identique
        return Gossip.new(row[0],row[1])                          # Si c'est le cas, je retourne la valeur de ladite ligne
      end
    end
  end

  def self.edit(id, gossip_edited)
    new_id = id.to_i
    new_id -= 1
    puts new_id
    gossip_temp = CSV.read("./db/gossip.csv") # On recharge le contenu du fichier csv dans une variable gossip_temp pour la manipuler
    File.truncate("./db/gossip.csv", 0) # On efface tout le contenu du fichier csv
    deleted = []
    i = 0

    # On reecrit dans le fichier seulement les lignes qui ne correspondent pas au choix
    gossip_temp.each do |line|
      CSV.open("./db/gossip.csv", "ab") do |csv|
        unless i == new_id # On compare si on arrive `a la ligne choisie
          csv << line
        else # si c'est e cas, on ne re-ecrit pas, on enregistre pour information
          csv << [gossip_edited.author,gossip_edited.content]
        end
      end
      i += 1 # compteur de lignes
    end
  end


end
