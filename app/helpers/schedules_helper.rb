module SchedulesHelper
  
  def dose_info(vaccine, month)
    vaccine.doses.each do |dose|
      if month == dose.months_scheduled_from_date_of_birth
        rowspan= 0
        @schedule.dose_months.each do |month|
          rowspan+= 1 if (dose.months_scheduled_from_date_of_birth <= month && 
month <= dose.months_scheduled_from_date_of_birth + dose.administration_window_in_months - 1)
        end
        
        return ('<td colspan="' + rowspan.to_s + '">' + dose.vaccine.short_name + 
        '<br />due:&nbsp;' + (dose.vaccine.schedule.date_of_birth.advance(months: dose.months_scheduled_from_date_of_birth)).to_s + 
        (dose.administration_window_in_months > 0 ? 
        "&mdash;" + (dose.vaccine.schedule.date_of_birth.advance(months: dose.months_scheduled_from_date_of_birth + 
        dose.administration_window_in_months, days: -1)).to_s  : "" ) + 
        '<br />given:&nbsp;' + dose.date_administered.to_s + '</td>').html_safe
      elsif (dose.months_scheduled_from_date_of_birth < month && 
month <= dose.months_scheduled_from_date_of_birth + dose.administration_window_in_months)
        return ""
      end
    end
    
    return "<td>&nbsp</td>".html_safe
  end
  
end