require "rubygems"
 require "json"
class SprintDatum < ActiveRecord::Base

def self.createdata(jirastatus)

@count = Test.group(:component).where("status= ? and strftime('%Y-%m-%d',created_at)=?",jirastatus, Time.zone.now.to_date).count('issuekey')
@day_data = SprintDatum.new
@day_data.day = Time.now()
@day_data.jirastatus = jirastatus
@newhash = {}

    @count.each do |key,value|
    comp = key
    
    @newhash[comp] ||= {}
  
   @newhash[comp][:no_of_tickets] = @count[key]
	@hashforcomponent = Test.all.order(:component).where("status= ? and strftime('%Y-%m-%d',created_at)=?",jirastatus, Time.zone.now.to_date).order('ticket_created_at DESC')
      @newhash[comp][:Hours] = []
      @newhash[comp][:Ticket] = []
      @newhash[comp][:InTriage] = []
      
      @hashforcomponent.each do |var| 
          if var.component == key
           puts var.ticket_created_at.class
         @newhash[comp][:Hours] << ((Time.now()-Time.parse(var.ticket_created_at))/(3600*24)).round(2)
          @newhash[comp][:Ticket] << var.issuekey
           @newhash[comp][:InTriage] << var.ticket_created_at 
           else
          end

      	end
      	if value >1 
    percentile_ninety =  (value*0.9).floor    
    percentile_fifty = (value*0.5).floor

     @newhash[comp][:per_90]  = @newhash[comp][:Hours][percentile_ninety-1]
    @newhash[comp][:per_50] = @newhash[comp][:Hours][percentile_fifty-1]
	elsif value == 1
 	percentile_ninety =  (value*0.9).ceil   
    percentile_fifty = (value*0.5).ceil
	@newhash[comp][:per_90]  = @newhash[comp][:Hours][percentile_ninety-1]
    @newhash[comp][:per_50] = @newhash[comp][:Hours][percentile_fifty-1]
	end

	@day_data.componenthash = @newhash.to_json

	@hashcolumn = JSON.parse(@day_data.componenthash)
	end  #top most do loop

	@day_data.save


end
end
