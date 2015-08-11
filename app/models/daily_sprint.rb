
require "rubygems"
 require "json"
 require "hipchat"
class DailySprint < ActiveRecord::Base
  def self.creatingnewdata
    
    @count_one = Report.group(:component).where("strftime('%Y-%m-%d',created_at)=?", Time.zone.now.to_date).count('issuekey')
    
puts @count_one
@day_data = DailySprint.new
@day_data.day = Time.now()

@newhash = {}

    @count_one.each do |key,value|
    comp = key
    
    @newhash[comp] ||= {}
  
   @newhash[comp][:no_of_tickets] = @count_one[key]
  

    @hashforcomponent = Report.all.order(:component).where(" strftime('%Y-%m-%d',created_at)=?" , Time.zone.now.to_date)
     
      
      @newhash[comp][:Ticket] = []
      @newhash[comp][:CurrentStatus] = []
     @newhash[comp][:TimeinStatus] = []
     @newhash[comp][:TimeinReadytoMerge] = []
     
      sum = 0
      sumRM = 0
      countCR =0
      countRM = 0
      @hashforcomponent.each do |var| 
          if var.component == key
          
          @newhash[comp][:Ticket] << var.issuekey
          @newhash[comp][:CurrentStatus] <<  var.current_status
         puts var.time_in_codereview.class
         puts var.issuekey
           @newhash[comp][:TimeinStatus] << var.time_in_codereview 
           if var.time_in_codereview > 0
           	countCR= countCR +1 
			end
           @newhash[comp][:TimeinReadytoMerge] << var.time_in_readytomerge
           if var.time_in_readytomerge > 0
           	countRM = countRM +1
           end
           sum = sum+ var.time_in_codereview
           sumRM = sumRM + var.time_in_readytomerge
           
          else
          end

      end
      puts countCR
if countCR > 0 
avg= sum/countCR/3600/24
else
	avg = 0
end
 puts countRM
if  countRM > 0
avgRM = sumRM/countRM/3600/24
else
	avgRM = 0
end   
    @newhash[comp][:avg]  = avg
    @newhash[comp][:avgRM] = avgRM

@day_data.componenthash = @newhash.to_json

 @hashcolumn = JSON.parse(@day_data.componenthash)
end  #top most do loop

@day_data.save



end
end



