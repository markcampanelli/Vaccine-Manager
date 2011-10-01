class CreateDoses < ActiveRecord::Migration
  def change
    create_table :doses do |t|
      t.references :vaccine
      
      t.date :days_scheduled_from_date_of_birth
      t.date :date_administered
      t.text :notes
#      t.integer :start_month
#      t.integer :admin_window
#      t.boolean :booster
      
      t.timestamps
    end
  end
end
