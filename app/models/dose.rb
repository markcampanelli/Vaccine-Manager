class Dose < ActiveRecord::Base
  
  belongs_to :vaccine
  
  attr_accessible :months_scheduled_from_date_of_birth, :administration_window_in_months, :date_administered, :notes
  
  validates :months_scheduled_from_date_of_birth, presence: true, numericality: { only_integer: { greater_than_or_equal_to: 0 } }
  validates :administration_window_in_months, presence: true, numericality: { only_integer: { greater_than_or_equal_to: 1 } }
  validate :date_administered_is_valid
  
  def date_administered_is_valid
    unless date_administered.nil?
      errors.add(:date_administered, "can't occur before date of birth (" + self.vaccine.short_name.to_s + ")") if date_administered < self.vaccine.schedule.date_of_birth
      
      administered_doses_before= self.vaccine.doses.select { |dose| !dose.date_administered.nil? && 
dose.months_scheduled_from_date_of_birth < self.months_scheduled_from_date_of_birth }
      errors.add(:date_administered, "can't be before a previous administered dose's administration date (" + 
self.vaccine.short_name.to_s + ")") unless 
(administered_doses_before.select { |dose_before| dose_before.date_administered > self.date_administered }).empty?
    end
  end
  
end
