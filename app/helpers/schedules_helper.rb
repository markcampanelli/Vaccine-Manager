module SchedulesHelper
    
  def dose_colspan(dose, month)
    dose_colspan= 0
    @schedule.dose_months.each do |month|
      dose_colspan+= 1 if (dose.months_scheduled_from_date_of_birth <= month && 
month <= dose.months_scheduled_from_date_of_birth + dose.administration_window_in_months - 1)
    end
    
    return dose_colspan
  end
  
end