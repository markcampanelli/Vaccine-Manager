class CreateDoses < ActiveRecord::Migration
  def change
    create_table :doses do |t|
      t.references :vaccine
      
      t.integer :months_scheduled_from_date_of_birth
      t.integer :administration_window_in_months
      t.date :date_administered
      t.text :notes
#      t.boolean :booster
      
      t.timestamps
    end
  end
end
