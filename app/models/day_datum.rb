require "rubygems"
 require "json"
 require "hipchat"

class DayDatum < ActiveRecord::Base

  def self.creatingnewdata(jirastatus, inSprintValue)
    if inSprintValue == "Y"
    @count_one = Jira.group(:component).where("status= ? and strftime('%Y-%m-%d',created_at)=? and InSprint=?",jirastatus, Time.zone.now.to_date, "Y").count('issuekey')
    else 
    @count_one = Jira.group(:component).where("status= ? and strftime('%Y-%m-%d',created_at)=? and InSprint=?",jirastatus, Time.zone.now.to_date, "N").count('issuekey')
    end
puts @count_one
@day_data = DayDatum.new
@day_data.day = Time.now()
@day_data.jirastatus = jirastatus
    if inSprintValue == "Y"
    @day_data.InSprint = "Y"
    else
    @day_data.InSprint = "N"
    end
@newhash = {}

    @count_one.each do |key,value|
    comp = key
    
    @newhash[comp] ||= {}
  
   @newhash[comp][:no_of_tickets] = @count_one[key]
  
if inSprintValue == "Y"
    @hashforcomponent = Jira.all.order(:component).where("status= ? and strftime('%Y-%m-%d',created_at)=? and InSprint=?",jirastatus, Time.zone.now.to_date, "Y").order('ticket_created_at DESC')
     else
       @hashforcomponent = Jira.all.order(:component).where("status= ? and strftime('%Y-%m-%d',created_at)=? and InSprint=?",jirastatus, Time.zone.now.to_date, "N").order('ticket_created_at DESC')
     end
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
 #puts var.component
if key == var.component
  puts val
for i in 1..val
puts @newhash[comp][:Hours][i-1]
puts @newhash[comp][:Hours][percentile_ninety-1]
if @newhash[comp][:Hours][i-1] > @newhash[comp][:Hours][percentile_ninety-1]
    

   var.link= @newhash[comp][:Ticket][i-1]
   puts var.link
   client = HipChat::Client.new('jibcQFwKU0MurUIWUp0f3vAd30aBd8XWrF1uBimk',:api_version => 'v2', :server_url => 'https://coupa.hipchat.com')
    client.user(var.name).send('Ticket no. '+var.link+' belonging to '+var.component+' in '+'jirastatus'+' status. The link is :'+ 'https://coupadev.atlassian.net/browse/'+var.link)
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


