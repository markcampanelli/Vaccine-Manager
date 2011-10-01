module SchedulesHelper
  
  def dose_info(dose)
    (dose.vaccine.short_name + 
'<br /> due: ' + (dose.vaccine.schedule.date_of_birth.advance(months: dose.months_scheduled_from_date_of_birth)).to_s + 
(dose.administration_window_in_months > 0 ? 
"&mdash;" + (dose.vaccine.schedule.date_of_birth.advance(months: dose.months_scheduled_from_date_of_birth + 
dose.administration_window_in_months, days: -1)).to_s  : "" ) + 
'<br /> given: ' + dose.date_administered.to_s).html_safe
  end
  
end
