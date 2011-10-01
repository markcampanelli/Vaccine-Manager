module SchedulesHelper
  
  def dose_info(dose)
    (dose.vaccine.short_name + 
'<br /> due: ' + (dose.vaccine.schedule.date_of_birth + dose.days_scheduled_from_date_of_birth.days).to_s + 
'<br /> given: ' + dose.date_administered.to_s).html_safe
  end
  
end
