class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :person_name
      t.date :date_of_birth
      t.string :template
      t.text :notes

      t.timestamps
    end
  end
end
