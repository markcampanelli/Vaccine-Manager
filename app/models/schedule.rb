class Schedule < ActiveRecord::Base
  
  Templates= [ 'U.S. CDC 2011', 'Custom' ]
  
  has_many :vaccines, dependent: :destroy, order: :position
  has_many :doses, through: :vaccines
  accepts_nested_attributes_for :vaccines, allow_destroy: true
 
  attr_accessible :person_name, :date_of_birth, :date_of_birth_year, :template, :notes, :vaccines_attributes
  
  validates :person_name, presence: true, uniqueness: true
  validates :date_of_birth, presence: true
  validates :date_of_birth_year, presence: true, numericality: { only_integer: true }
  validates :template, presence: true, inclusion: { in: Templates }
  validates_associated :vaccines
  
  def date_of_birth_year
    @date_of_birth_year ||= self.date_of_birth.year
  end

  def date_of_birth_year=(year)
    @date_of_birth_year= year
  end
  
  def dose_months
    dose_months= SortedSet.new()
    
    self.doses.each do |dose|
      dose_months << dose.months_scheduled_from_date_of_birth
      dose_months << (dose.months_scheduled_from_date_of_birth + dose.administration_window_in_months - 1)
    end
    
    return dose_months
  end
  
 # TBD: Should be protected or folded into overridden new method?
  def template_vaccines
    case self.template
      when Templates[0] # U.S. CDC 2011
        return [ 
{ position: 1, name: 'Hepatitis B', short_name: 'HepB', doses_attributes: [
{ months_scheduled_from_date_of_birth: 0, administration_window_in_months: 1 }, 
{ months_scheduled_from_date_of_birth: 1, administration_window_in_months: 2 }, 
{ months_scheduled_from_date_of_birth: 6, administration_window_in_months: 13 } ] },
{ position: 2, name: 'Rotavirus', short_name: 'RV', doses_attributes: [
{ months_scheduled_from_date_of_birth: 2, administration_window_in_months: 1 }, 
{ months_scheduled_from_date_of_birth: 4, administration_window_in_months: 1 }, 
{ months_scheduled_from_date_of_birth: 6, administration_window_in_months: 1 } ] },
{ position: 3, name: 'Diphtheria, Tetanus, & acellular Pertussis', short_name: 'DTaP', doses_attributes: [
{ months_scheduled_from_date_of_birth: 2, administration_window_in_months: 1 }, 
{ months_scheduled_from_date_of_birth: 4, administration_window_in_months: 1 }, 
{ months_scheduled_from_date_of_birth: 6, administration_window_in_months: 1 },
{ months_scheduled_from_date_of_birth: 15, administration_window_in_months: 3 },
{ months_scheduled_from_date_of_birth: 4*12, administration_window_in_months: 3*12 } ] }, 
{position: 4, name: 'Haemophilus influenzae type b', short_name: 'Hib', doses_attributes: [
{ months_scheduled_from_date_of_birth: 2, administration_window_in_months: 1 }, 
{ months_scheduled_from_date_of_birth: 4, administration_window_in_months: 1 }, 
{ months_scheduled_from_date_of_birth: 6, administration_window_in_months: 1 },
{ months_scheduled_from_date_of_birth: 12, administration_window_in_months: 4 } ] }, 
{position: 5, name: 'Pneumococcal conjugate vaccine, 13-valent', short_name: 'PCV13', doses_attributes: [
{ months_scheduled_from_date_of_birth: 2, administration_window_in_months: 1 }, 
{ months_scheduled_from_date_of_birth: 4, administration_window_in_months: 1 }, 
{ months_scheduled_from_date_of_birth: 6, administration_window_in_months: 1 },
{ months_scheduled_from_date_of_birth: 12, administration_window_in_months: 4 } ] }, 
{position: 6, name: 'Inactivated poliovirus vaccine', short_name: 'IPV', doses_attributes: [
{ months_scheduled_from_date_of_birth: 2, administration_window_in_months: 1 }, 
{ months_scheduled_from_date_of_birth: 4, administration_window_in_months: 1 }, 
{ months_scheduled_from_date_of_birth: 6, administration_window_in_months: 13 },
{ months_scheduled_from_date_of_birth: 4*12, administration_window_in_months: 3*12 } ] },
#{position: 7, name: 'Trivalent inactivated influenza vaccine', short_name: 'TIV', doses_attributes: [
#{ months_scheduled_from_date_of_birth: 6, administration_window_in_months: 12 },
#{ months_scheduled_from_date_of_birth: 18, administration_window_in_months: 12 } ] }, 
#{position: 8, name: 'Live, attenuated influenza vaccine', short_name: 'LAIV', doses_attributes: [
#{ months_scheduled_from_date_of_birth: 30, administration_window_in_months: 12 }, 
#{ months_scheduled_from_date_of_birth: 42, administration_window_in_months: 12 },
#{ months_scheduled_from_date_of_birth: 54, administration_window_in_months: 12 },
#{ months_scheduled_from_date_of_birth: 66, administration_window_in_months: 12 },
#{ months_scheduled_from_date_of_birth: 78, administration_window_in_months: 12 } ] },
{position: 7, name: 'Measles, Mumps, & Rubella', short_name: 'MMR', doses_attributes: [
{ months_scheduled_from_date_of_birth: 12, administration_window_in_months: 4 }, 
{ months_scheduled_from_date_of_birth: 4*12, administration_window_in_months: 3*12 } ] }, 
{position: 8, name: 'Varicella', short_name: 'Varicella', doses_attributes: [
{ months_scheduled_from_date_of_birth: 12, administration_window_in_months: 4 }, 
{ months_scheduled_from_date_of_birth: 4*12, administration_window_in_months: 3*12 } ] }, 
{position: 9, name: 'Hepatitis A', short_name: 'HepA', doses_attributes: [
{ months_scheduled_from_date_of_birth: 12, administration_window_in_months: 4 },
{ months_scheduled_from_date_of_birth: 23, administration_window_in_months: 1 } ] } ]
        
      when Templates[1] # Custom
        return []

      else
        puts "MESSAGE: Invalide template (" + template.to_s + ") detected."
        return []
    end
  end
  
end
