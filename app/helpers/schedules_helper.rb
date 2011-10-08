module SchedulesHelper
    
  def dose_name(vaccine, month)
    vaccine.doses.each do |dose|
      if month == dose.months_scheduled_from_date_of_birth
        return ('<td colspan="' + dose_rowspan(dose, month).to_s + '">' + dose.vaccine.short_name + "</td>").html_safe

      elsif (dose.months_scheduled_from_date_of_birth < month && 
  month < dose.months_scheduled_from_date_of_birth + dose.administration_window_in_months)
        return ""

      end
    end
    
    return "<td>&nbsp</td>".html_safe
  end

  def dose_scheduled(vaccine, month)
    vaccine.doses.each do |dose|
      if month == dose.months_scheduled_from_date_of_birth
        return ('<td style="white-space: nowrap" colspan="' + dose_rowspan(dose, month).to_s + '">due:&nbsp;' + 
(dose.vaccine.schedule.date_of_birth.advance(months: dose.months_scheduled_from_date_of_birth)).to_s + 
(dose.administration_window_in_months > 0 ? 
"&mdash;" + (dose.vaccine.schedule.date_of_birth.advance(months: dose.months_scheduled_from_date_of_birth + 
dose.administration_window_in_months, days: -1)).to_s  : "" ) + "</td>").html_safe

      elsif (dose.months_scheduled_from_date_of_birth < month && 
month < dose.months_scheduled_from_date_of_birth + dose.administration_window_in_months)
        return ""
        
      end
    end
    
    return "<td>&nbsp</td>".html_safe
  end

  def dose_given(vaccine, month)
    vaccine.doses.each do |dose|
      if month == dose.months_scheduled_from_date_of_birth
        return ('<td style="white-space: nowrap" colspan="' + dose_rowspan(dose, month).to_s + '">given:&nbsp;' + 
dose.date_administered.to_s + '</td>').html_safe

      elsif (dose.months_scheduled_from_date_of_birth < month && 
month < dose.months_scheduled_from_date_of_birth + dose.administration_window_in_months)
        return ""

      end
    end
    
    return "<td>&nbsp</td>".html_safe
  end
  
  def dose_colspan(dose, month)
    dose_colspan= 0
    @schedule.dose_months.each do |month|
      dose_colspan+= 1 if (dose.months_scheduled_from_date_of_birth <= month && 
month <= dose.months_scheduled_from_date_of_birth + dose.administration_window_in_months - 1)
    end
    
    return dose_colspan
  end
  
end