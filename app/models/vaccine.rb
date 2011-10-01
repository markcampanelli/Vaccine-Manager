class Vaccine < ActiveRecord::Base

  Us_cdc_vaccines= [ # Years, months, and days are inclusive 
{position: 0, name: 'Hepatitis B', short_name: 'HepB', start_admin_min_days: 0}, 
{position: 1, name: 'Rotavirus', short_name: 'RV', start_admin_min_weeks: 6, start_admin_max_weeks: 14, 
start_admin_max_days: 6, stop_admin_months: 8, stop_admin_days: 0, doses_attributes: [
{ days_scheduled_from_date_of_birth: 30 }, { days_scheduled_from_date_of_birth: 60 }, 
{ days_scheduled_from_date_of_birth: 90 } ] 
}, 
{position: 2, name: 'Diphtheria, Tetanus, & acellular Pertussis', short_name: 'DTaP', start_admin_min_weeks: 6}, 
{position: 3, name: 'Haemophilus influenzae type b', short_name: 'Hib', start_admin_min_weeks: 6}, 
{position: 4, name: 'Pneumococcal conjugate vaccine, 13-valent', short_name: 'PCV13', start_admin_min_weeks: 6, start_admin_max_years: 5}, 
{position: 5, name: 'Inactivated poliovirus vaccine', short_name: 'IPV', start_admin_min_weeks: 6}, 
{position: 6, name: 'Trivalent inactivated influenza vaccine', short_name: 'TIV', start_admin_min_months: 6}, 
{position: 7, name: 'Live, attenuated influenza vaccine', short_name: 'LAIV', start_admin_min_years: 2}, 
{position: 8, name: 'Measles, Mumps, & Rubella', short_name: 'MMR', start_admin_min_years: 1}, 
{position: 9, name: 'Hepatitis A', short_name: 'HepA', start_admin_min_years: 1} ]
    
  belongs_to :schedule
  has_many :doses, dependent: :destroy
  accepts_nested_attributes_for :doses
  
  attr_accessible :position, :name, :short_name, :notes, :doses_attributes
  
  validates :name, presence: true, uniqueness: { scope: :schedule_id }
  validates :short_name, :presence => true, uniqueness: { scope: :schedule_id }
  validates :position, presence: true, uniqueness: { scope: :schedule_id }, 
:numericality => { only_integer: { greater_than_or_equal_to: 0 } }
  validates_associated :doses
  
end
