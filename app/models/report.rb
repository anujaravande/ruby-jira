class Report < ActiveRecord::Base

	def self.pulltickets

		@username = Rails.application.secrets.JIRA_USERNAME
		@pwd = Rails.application.secrets.JIRA_PASSWORD
		puts @username
		puts @pwd

		begin
			uri = URI.parse(report_url_one)
			puts uri
			uri2 = URI.parse(report_url_two)
			puts uri2

			http = Net::HTTP.new(uri.host, uri.port)
			http2 = Net::HTTP.new(uri2.host, uri2.port)
			http.use_ssl = true
			http2.use_ssl = true

			http.verify_mode = OpenSSL::SSL::VERIFY_NONE
			http2.verify_mode = OpenSSL::SSL::VERIFY_NONE


			request = Net::HTTP::Get.new(uri.request_uri)
			request2 = Net::HTTP::Get.new(uri2.request_uri)

			request.basic_auth @username, @pwd
			request2.basic_auth @username, @pwd  

			request["Content-Type"] = "application/json"
			request2["Content-Type"] = "application/json"

			response = http.request(request)
			response2 = http.request(request2) 
		rescue Net::ReadTimeout
			puts "Please try again"
		end

		puts response.code
		puts response2.code
		if response.code =~ /20[0-9]{1}/

			data1 = JSON.parse(response.body)
			data2 = JSON.parse(response2.body)
			puts data1["issues"].count
			puts data2["issues"].count
			data2["issues"].each do |x|

				data1["issues"] << x
			end
			puts data1["issues"].count


			puts data1["total"]
			data1["issues"].each do |var|

				entry = Report.new

				datathree = var["changelog"]["histories"]
				puts 
				@diff = 0
				@diffRM = 0
				@dateone = nil
				@datetwo = nil
				@dateoneRM = nil
				@datetwoRM = nil

				datathree.each do |x|

					datafour = x["items"].first

					if datafour["toString"] == "Code Review" 
						@dateone= x["created"] 
					end
					if datafour["toString"] == "Ready to Merge"
						@dateoneRM = x["created"]
					end

					if datafour["fromString"] == "Code Review"
						@datetwo = x["created"]
					end

					if datafour["fromString"] == "Ready to Merge"
						@datetwoRM = x["created"]
					end

					if @dateone!= nil and @datetwo != nil
						@diff = @diff + (Time.parse(@datetwo) - Time.parse(@dateone)).to_f
						@dateone = nil
						@datetwo = nil
					end
					if @dateoneRM!= nil and @datetwoRM != nil
						@diffRM = @diffRM + (Time.parse(@datetwoRM) - Time.parse(@dateoneRM)).to_f
						@dateoneRM = nil
						@datetwoRM = nil
					end

          end #datathree end        	
          if @dateone == nil and @datetwo ==nil
          	entry.time_in_codereview = @diff
          #elsif @dateone == nil 
          #	puts @dateone
          #	puts "******"+ @datetwo+ "*********"
          #	entry.time_in_codereview = 0
      elsif @datetwo == nil and @dateone !=nil
      	puts "DATEONE : "+@dateone
      	puts Time.now - Time.parse(@dateone)
      	entry.time_in_codereview = @diff+ (Time.now - Time.parse(@dateone)).to_f

      end

      if @dateoneRM == nil and @datetwoRM ==nil
      	entry.time_in_readytomerge = @diffRM
          #elsif @dateone == nil 
          #	puts @dateone
          #	puts "******"+ @datetwo+ "*********"
          #	entry.time_in_codereview = 0
      elsif @datetwoRM == nil and @dateoneRM !=nil
      	puts "DATEONE : "+@dateoneRM
      	puts Time.now - Time.parse(@dateoneRM)
      	entry.time_in_readytomerge = @diffRM + (Time.now - Time.parse(@dateoneRM)).to_f

      end

      entry.issuekey = var["key"]
      entry.current_status = var["fields"]["status"]["name"]
      entry.component = var["fields"]["components"].first["name"] unless var["fields"]["components"].first==nil 
      if var["fields"]["components"].first==nil


      	entry.component = "** No component **"
      end
      entry.save!
      puts entry.inspect

              end # data1[issues] end
end #if response end
end #method end
end

