class SchedulesController < ApplicationController
    
  before_filter :load_date_of_birth, only: [ :create, :update ]
  
  # GET /schedules
  # GET /schedules.json
  def index
    @schedules= Schedule.all
    @subtitle= ": Schedules Listing"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schedules }
    end
  end

  # GET /schedules/1
  # GET /schedules/1.json
  def show    
    @schedule= Schedule.find(params[:id])
    @subtitle= ": Viewing Schedule for " << @schedule.person_name

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @schedule }
    end
  end

  # GET /schedules/new
  # GET /schedules/new.json
  def new
    @schedule= Schedule.new(date_of_birth: Date.today)
    @subtitle= ": Entering New Schedule"

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @schedule }
    end
  end

  # GET /schedules/1/edit
  def edit
    @schedule= Schedule.find(params[:id])
    @subtitle= ": Editing Schedule for " << @schedule.person_name
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @schedule= Schedule.new(params[:schedule])
    @schedule.vaccines.build(@schedule.template_vaccines)
       
    respond_to do |format|
      if @schedule.save
        format.html { redirect_to @schedule, notice: 'Schedule was successfully created.' }
        format.json { render json: @schedule, status: :created, location: @schedule }
      else
        format.html { render action: "new" }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /schedules/1
  # PUT /schedules/1.json
  def update
    @schedule= Schedule.find(params[:id])

    respond_to do |format|
      if @schedule.update_attributes(params[:schedule])
        format.html { redirect_to @schedule, notice: 'Schedule was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    @schedule= Schedule.find(params[:id])
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to schedules_url }
      format.json { head :ok }
    end
  end
  
  protected
    
  def load_date_of_birth
    # WIP: Add date_of_birth validation
     unless params[:date_of_birth][:year].blank?
       params[:schedule]["date_of_birth(1i)"]= params[:date_of_birth][:year]
       params[:schedule]["date_of_birth(2i)"]= params[:date_of_birth][:month]
       params[:schedule]["date_of_birth(3i)"]= params[:date_of_birth][:day]
     end
  end
  
end
