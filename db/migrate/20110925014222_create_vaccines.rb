class CreateVaccines < ActiveRecord::Migration
  def change
    create_table :vaccines do |t|
      t.references :schedule

      t.integer :position
      t.string :name
      t.string :short_name
      t.text :notes
#      t.integer :start_admin_min_years
#      t.integer :start_admin_min_months
#      t.integer :start_admin_min_weeks
#      t.integer :start_admin_min_days
#      t.integer :start_admin_max_years
#      t.integer :start_admin_max_months
#      t.integer :start_admin_max_weeks
#      t.integer :start_admin_max_days
#      t.integer :stop_admin_years
#      t.integer :stop_admin_months
#      t.integer :stop_admin_weeks
#      t.integer :stop_admin_days

      t.timestamps
    end
  end
end
