class Jira < ActiveRecord::Base
  #def initialize

#ruby -r "./jiratest.rb" -e "Jiratest.new.pull_tickets"
puts "hello"

  @username = Rails.application.secrets.JIRA_USERNAME
  @pwd = Rails.application.secrets.JIRA_PASSWORD

def self.pull_tickets(jirastatus)
  
  @username = Rails.application.secrets.JIRA_USERNAME
  @pwd = Rails.application.secrets.JIRA_PASSWORD

# JIRA REST API to pull tickets

  uri = URI.parse(Rails.application.secrets.Jira_url)
  puts uri
  http = Net::HTTP.new(uri.host, uri.port)
  #http2 = Net::HTTP.new(uri2.host, uri2.port)
    http.use_ssl = true
  #  http2.use_ssl = true
    
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
   # http2.verify_mode = OpenSSL::SSL::VERIFY_NONE  
    request = Net::HTTP::Get.new(uri.request_uri)
#  request2 = Net::HTTP::Get.new(uri2.request_uri)
    
    request.basic_auth @username, @pwd
 #   request2.basic_auth @username, @pwd  
  
    request["Content-Type"] = "application/json"
  #request2["Content-Type"] = "application/json"
  
    response = http.request(request)
   #response2 = http.request(request2) 
  
    puts response.code
    if response.code =~ /20[0-9]{1}/

        data = JSON.parse(response.body)
        # loop for parsing through all issues
        data["issues"].each do |var|
              entry = Jira.new
              if var["fields"]["project"]["key"] == 'JZ' or var["fields"]["project"]["key"]=='CD'
              if jirastatus=="Waiting for Triage"
                entry.ticket_created_at = var["fields"]["created"]
              end   
                datathree = var["changelog"]["histories"]
     
                datathree.each do |x|
                datafour = x["items"]
                datafour.each do |y|
                  if y["toString"] == jirastatus
                    
                  puts x["created"]
                  puts x["created"].class
                  entry.ticket_created_at = x["created"]
                  end
                end #datafour end
                end # daatathree do end
      entry.issuekey = var["key"]
      puts var["key"]
      entry.projectname = var["fields"]["project"]["name"]
      entry.component = var["fields"]["components"].first["name"] unless var["fields"]["components"].first==nil 
          if var["fields"]["components"].first==nil
              entry.component = "** No component **"
          end
      entry.status = var["fields"]["status"]["name"]
        #puts entry.status
            
      entry.save!
        end
      end # data do end
 
end # if response end

end # method end 
end


