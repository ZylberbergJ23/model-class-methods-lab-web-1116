class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
  	self.joins(boats: :classifications).where("classifications.name = 'Catamaran'")
  	#self.joins(boats: :classifications).where(classifications: {name: "Catamaran"})
  end 	

  def self.sailors
  	self.joins(boats: :classifications).where("classifications.name = 'Sailboat'").uniq
  end 


  # def self.motorboaters
  #     self.joins(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  #  end

  def self.talented_seamen
  	# self.where('id IN (?)', self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  	self.joins(boats: :classifications).where("classifications.name = 'Sailboat' OR classifications.name = 'Motorboat'").group("classifications.name").order("classifications.name DESC")
  end	

  def self.non_sailors
  	self.where.not("captains.id in (?)", self.sailors.pluck(:id))
  	# self.where.not('id IN (?)', self.sailors.pluck(:id))
  end 

end


#pluck gets the stuff in the column, so self.sailors.pluck(:id) will get the ids for the quesry you are doing 


