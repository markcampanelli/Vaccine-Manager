class Vaccine < ActiveRecord::Base

  belongs_to :schedule
  has_many :doses, dependent: :destroy
  accepts_nested_attributes_for :doses
  
  attr_accessible :position, :name, :short_name, :notes, :doses_attributes
  
  validates :position, presence: true, uniqueness: { scope: :schedule_id }, 
  :numericality => { only_integer: { greater_than_or_equal_to: 1 } }
  validates :name, presence: true, uniqueness: { scope: :schedule_id }
  validates :short_name, :presence => true, uniqueness: { scope: :schedule_id }
  validates_associated :doses
    
end
