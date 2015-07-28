class JirasController < ApplicationController
 # before_action :set_jira, only: [:show, :edit, :update, :destroy]

  # GET /jiras
  # GET /jiras.json
  def index
   
    @jiras = Jira.group(:component)
   # @jiraticket = Jira.new 
   @jira = Jira.new
   # @jiraticket.pull_tickets
   

    respond_to do |format|
      format.html
      #format.json {render json: @jiras}
#@group_components = Jira.group(:component)
    end
  end

def highlevel
  @jirastatusarr = []
  @days = DayDatum.all.where("strftime('%Y-%m-%d',created_at)=?", Time.zone.now.to_date)
  @days.each do |var|
        @jirastatusarr << var.jirastatus
    end
   params[:jirastatus] = params[:jirastatus] || "Waiting for Triage"
   @dayall = DayDatum.all.where("strftime('%Y-%m-%d',created_at)=?", Time.zone.now.to_date).where(jirastatus: params[:jirastatus])
  respond_to do |format|
    format.html
  end
end


  # GET /jiras/1
  # GET /jiras/1.json
  def show
   
    respond_to do |format|
     format.html
    #format.json {render json: @jiras}

    end
  end

  def componentview
  @dayall = DayDatum.all  
 @dayall.each do |var| 
   @hashcolumn = JSON.parse(var.componenthash) 
   puts var.day.class
 puts params[:day].class
 puts var.day == params[:day]
  if var.day.to_s == params[:day].to_s
  @hashcolumn.each do |key,val| 
    if key == params[:status]

    puts key
   for i in 0...val["no_of_tickets"]
   #binding.pry
   puts i
   puts val["InTriage"][i]
   puts (Time.now() - Time.parse(val["InTriage"][i]))/(3600*24)
    end #for end
    end  # if
  end # do |key, val|
end #if end
end  # first do

 #@count_value = Jira.where("status=?",params[:status]).where("strftime('%Y-%m-%d',created_at)=?",Date.today).count('issuekey')
 #@percentile_ninety = (@count_value*0.9).floor 
 #@percentile_fifty = (@count_value*0.5).floor 

 
respond_to do |format|
      
      format.html
      end
  end

def customview
  puts params.inspect
 @dayall = DayDatum.all.where(jirastatus: params[:status])
respond_to do |format| 
      format.html
      end
  end


def weeklyview
@dayall = DayDatum.all
@days =  DayDatum.group(:jirastatus)
@jirastatusarr = []
@days.each do |getstatus|
@jirastatusarr << getstatus.jirastatus
end
puts @jirastatusarr
@groupedcomp = Jira.group(:component)
 @groupedcomp.each do |jira| 
   @arr ||= [] 
   @arr << jira.component 
  end
   params[:jirastatus] = params[:jirastatus] || "Waiting for Triage"
  @daily = DayDatum.all.where(jirastatus: params[:jirastatus])

=begin  

  puts @arr.length
 @dayall.each do |var| 
 i = 0 
   @hashcolumn = JSON.parse(var.componenthash) 
   
     #var.day 
     @arr.each do |x|

  @hashcolumn.each do |key,val| 
  if x == key
    
    puts key
  end
  
  end
  end
end
=end 
=begin
 @issues_by_week = {}
 @jiraall.each do |jira| 
    
  weeknum = jira.hoursintriage.strftime("%U").to_i 
@issues_by_week[weeknum] ||= []
@issues_by_week[weeknum] << jira.issuekey


@components= Jira.where("status=?", params[:status])

@count_value = Jira.where("status=?",params[:status]).count('issuekey')
 @percentile_ninetynine = (@count_value*0.99).floor 
 puts @percentile_ninetynine
 @percentile_fifty = (@count_value*0.5).floor 
i = 0
@components.each do |jira|
 if i == @percentile_ninetynine 
 @percentileone = (Time.now()-jira.hoursintriage)/(3600*24*7) 
elsif i == @percentile_fifty
@percentiletwo = (Time.now()-jira.hoursintriage)/(3600*24*7)
else
  i= i+1
  end
end
@count_one = Jira.group(:status).count('issuekey')
@newhash = {}

    @count_one.each do |key,value|
    comp = key
    puts comp
    @newhash[comp] ||= []
    
    @newhash[comp] << @count_one[key]
    
    @hashforcomponent = Jira.all.order(:status)
      @hashforcomponent.each do |var| 
          if var.status == key
          @newhash[comp] << ((Time.now()-var.hoursintriage)/(3600*24*7)).round(2)
          else
          end

      end
    val= @newhash[comp].count

    percentile_ninety =  ((val-1)*0.9).floor
    percentile_fifty = ((val-1)*0.5).floor
     @newhash[comp] << @newhash[comp][percentile_ninety]
    @newhash[comp] << @newhash[comp][percentile_fifty]
  
end
=end

 respond_to do |format|
      format.html
      end
 end

def chartview 
  @dayall = DayDatum.all
@dayall.each do |var|
@hashcolumn = JSON.parse(var.componenthash)
@days ||= []
@days << var.day
end
@hashcolumn.each do |key,val|
  
  @a ||=[]
  @a << key
  @nooftickets ||= []
 @nooftickets << val["no_of_tickets"]

 end 
respond_to do |format|
      format.html
      end
end


  # GET /jiras/new
  def new
     #@count_value = Jira.distinct.count('issuekey')
    @jira = Jira.new

  end

  # GET /jiras/1/edit
  def edit
  end

  # POST /jiras
  # POST /jiras.json
  def create
    @jira = Jira.new(jira_params)


    respond_to do |format|
      if @jira.save
        format.html { redirect_to @jira, notice: 'Jira was successfully created.' }
        format.json { render :show, status: :created, location: @jira }
      else
        format.html { render :new }
        format.json { render json: @jira.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jiras/1
  # PATCH/PUT /jiras/1.json
  def update
    respond_to do |format|
      if @jira.update(jira_params)
        format.html { redirect_to @jira, notice: 'Jira was successfully updated.' }
        format.json { render :show, status: :ok, location: @jira }
      else
        format.html { render :edit }
        format.json { render json: @jira.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jiras/1
  # DELETE /jiras/1.json
  def destroy
    @jira.destroy
    respond_to do |format|
      format.html { redirect_to jiras_url, notice: 'Jira was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    #def set_jira
     
     # bin#ding.pry
     # @jira = Jira.find(params[:id])
    #end#
#
    # Never trust parameters from the scary internet, only allow the white list through.
    def jira_params
#      params.require(:jira).permit(:issuekey, :projectname, :component#)
    end
end
