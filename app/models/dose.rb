class Dose < ActiveRecord::Base
  
  belongs_to :vaccine
  
  attr_accessible :months_scheduled_from_date_of_birth, :administration_window_in_months, :date_administered, :notes
  
  validates :months_scheduled_from_date_of_birth, presence: true, 
:numericality => { only_integer: { greater_than_or_equal_to: 0 } }
  validates :administration_window_in_months, presence: true, 
:numericality => { only_integer: { greater_than_or_equal_to: 0 } }
#  WIP: Validate that :date_administered is >= the DOB in schedule. (What about DOB changes?)


end
