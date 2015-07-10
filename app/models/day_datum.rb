require "rubygems"
 require "json"
 require "hipchat"
class DayDatum < ActiveRecord::Base
def self.creatingnewdata 
@count_one = Jira.group(:status).where("strftime('%Y-%m-%d',created_at)=?",Date.today).count('issuekey')
puts @count_one
@day_data = DayDatum.new
@day_data.day = Time.now()
@newhash = {}

    @count_one.each do |key,value|
    comp = key
    
    @newhash[comp] ||= {}
  
   @newhash[comp][:no_of_tickets] = @count_one[key]
  

    @hashforcomponent = Jira.all.order(:status).where("strftime('%Y-%m-%d',created_at)=?",Date.today)
      @newhash[comp][:Hours] = []
      @newhash[comp][:Ticket] = []
      @hashforcomponent.each do |var| 
          if var.status == key
           
         @newhash[comp][:Hours] << ((Time.now()-var.hoursintriage)/(3600*24)).round(2)
          @newhash[comp][:Ticket] << var.issuekey
     
          else
          end

      end

    

    val= @count_one[key] 
puts val
if val >1 
    percentile_ninety =  (val*0.9).floor    
    percentile_fifty = (val*0.5).floor

     @newhash[comp][:per_90]  = @newhash[comp][:Hours][percentile_ninety-1]
    @newhash[comp][:per_50] = @newhash[comp][:Hours][percentile_fifty-1]
elsif val == 1
 percentile_ninety =  (val*0.9).ceil   
    percentile_fifty = (val*0.5).ceil
@newhash[comp][:per_90]  = @newhash[comp][:Hours][percentile_ninety-1]
    @newhash[comp][:per_50] = @newhash[comp][:Hours][percentile_fifty-1]
end

@day_data.componenthash = @newhash.to_json


mgr = Managerdet.all
mgr.each do |var|
 #puts key + "***************"
 puts var.component
if key == var.component
  puts val
for i in 1..val
puts @newhash[comp][:Hours][i-1]
puts @newhash[comp][:Hours][percentile_ninety-1]
if @newhash[comp][:Hours][i-1] > @newhash[comp][:Hours][percentile_ninety-1]
    

    var.link= @newhash[comp][:Ticket][i-1]
puts var.link
   client = HipChat::Client.new('jibcQFwKU0MurUIWUp0f3vAd30aBd8XWrF1uBimk',:api_version => 'v2', :server_url => 'https://coupa.hipchat.com')
    client.user(var.name).send('Ticket no. '+var.link+' belonging to '+var.component+' still in triage. '+'The link is :'+ 'https://coupadev.atlassian.net/browse/'+var.link)
  end
#elsif key == 'Approvals'
    end
 # for i in 1..val
  #if @newhash[comp][i] > @newhash[comp][percentile_ninety]
   #client = HipChat::Client.new('jibcQFwKU0MurUIWUp0f3vAd30aBd8XWrF1uBimk',:api_version => 'v2', :server_url => 'https://coupa.hipchat.com')
    #client.user('@VarunGore').send('Approvals')
    #end
  #end
end
end 

 @hashcolumn = JSON.parse(@day_data.componenthash)
end  #top most do loop

@day_data.save

 

end
end
