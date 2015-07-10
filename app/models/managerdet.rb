class Managerdet < ActiveRecord::Base
	def self.initialize 
		Managerdet.new(:component => "Inventory", :name => "@AnujaRavande").save
		
	
	end

end
