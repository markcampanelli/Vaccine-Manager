class DosesController < ApplicationController
  
 # PUT /doses/1
 # PUT /doses/1.json
  def update
    @dose= Dose.find(params[:id])

    respond_to do |format|
      if @dose.update_attributes(params[:dose])
        format.html { redirect_to @dose.vaccine.schedule, notice: 'Dose was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

end