class Schedule < ActiveRecord::Base
  
  Templates= [ 'U.S. CDC 2011', 'Custom' ]
  
  has_many :vaccines, dependent: :destroy, order: :position
  has_many :doses, through: :vaccines
  accepts_nested_attributes_for :vaccines
 
  attr_accessible :person_name, :date_of_birth, :template, :notes, :vaccines_attributes
 
  validates :person_name, presence: true, uniqueness: true
  validates :date_of_birth, presence: true
  validates :template, presence: true, inclusion: { in: Templates }
  validates_associated :vaccines

 # WIP: Should be protected or folded into overridden new method?
  def template_vaccines
    case self.template
      when Templates[0] # U.S. CDC 2011
        return [ 
{ position: 1, name: 'Hepatitis B', short_name: 'HepB', doses_attributes: [
{ months_scheduled_from_date_of_birth: 0, administration_window_in_months: 0 }, 
{ months_scheduled_from_date_of_birth: 1, administration_window_in_months: 2 }, 
{ months_scheduled_from_date_of_birth: 6, administration_window_in_months: 12 } ] },
{ position: 2, name: 'Rotavirus', short_name: 'RV', doses_attributes: [
{ months_scheduled_from_date_of_birth: 2, administration_window_in_months: 1 }, 
{ months_scheduled_from_date_of_birth: 4, administration_window_in_months: 1 }, 
{ months_scheduled_from_date_of_birth: 6, administration_window_in_months: 1 } ] },
{ position: 3, name: 'Diphtheria, Tetanus, & acellular Pertussis', short_name: 'DTaP', doses_attributes: [
{ months_scheduled_from_date_of_birth: 2, administration_window_in_months: 1 }, 
{ months_scheduled_from_date_of_birth: 4, administration_window_in_months: 1 }, 
{ months_scheduled_from_date_of_birth: 6, administration_window_in_months: 1 },
{ months_scheduled_from_date_of_birth: 15, administration_window_in_months: 4 },
{ months_scheduled_from_date_of_birth: 4*12, administration_window_in_months: 3*12 } ] }, 
{position: 4, name: 'Haemophilus influenzae type b', short_name: 'Hib', doses_attributes: [
{ months_scheduled_from_date_of_birth: 2, administration_window_in_months: 1 }, 
{ months_scheduled_from_date_of_birth: 4, administration_window_in_months: 1 }, 
{ months_scheduled_from_date_of_birth: 6, administration_window_in_months: 1 },
{ months_scheduled_from_date_of_birth: 12, administration_window_in_months: 3 } ] }, 
{position: 5, name: 'Pneumococcal conjugate vaccine, 13-valent', short_name: 'PCV13', start_admin_min_weeks: 6, start_admin_max_years: 5}, 
{position: 6, name: 'Inactivated poliovirus vaccine', short_name: 'IPV', start_admin_min_weeks: 6}, 
{position: 7, name: 'Trivalent inactivated influenza vaccine', short_name: 'TIV', start_admin_min_months: 6}, 
{position: 8, name: 'Live, attenuated influenza vaccine', short_name: 'LAIV', start_admin_min_years: 2}, 
{position: 9, name: 'Measles, Mumps, & Rubella', short_name: 'MMR', start_admin_min_years: 1}, 
{position: 10, name: 'Hepatitis A', short_name: 'HepA', start_admin_min_years: 1} 
]
        
      when Templates[1] # Custom
        return []

      else
        puts "MESSAGE: Invalide template (" + template.to_s + ") detected."
        return []
    end
  end
  
end
