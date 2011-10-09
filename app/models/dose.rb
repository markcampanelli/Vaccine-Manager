class Dose < ActiveRecord::Base
  
  belongs_to :vaccine
  
  attr_accessible :months_scheduled_from_date_of_birth, :administration_window_in_months, :date_administered, :notes
  
  validates :months_scheduled_from_date_of_birth, presence: true, numericality: { only_integer: { greater_than_or_equal_to: 0 } }
  validates :administration_window_in_months, presence: true, numericality: { only_integer: { greater_than_or_equal_to: 1 } }
#  validates :date_administered, allow_nil: true, numericality: { greater_than_or_equal_to: self.vaccine.schedule.date_of_birth }
  validate :date_administered_is_valid
  
  def date_administered_is_valid
    unless date_administered.nil?
      if date_administered < self.vaccine.schedule.date_of_birth
        errors.add(:date_administered, "can't occur before date of birth")
      end
    end
  end
  
end
