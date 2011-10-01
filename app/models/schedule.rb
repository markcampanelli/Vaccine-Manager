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
  
# WIP: Should be protected?
  def self.vaccine_attributes_for(template= nil)
    case template
      when Templates[0] # U.S. CDC 2011
        return Vaccine::Us_cdc_vaccines
        
      when Templates[1] # Custom
        return []
        
      else
        puts "MESSAGE: Invalide template (" + template.to_s + ") detected."
        return []
    end
  end
  
end
