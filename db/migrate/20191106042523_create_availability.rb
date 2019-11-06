class CreateAvailability < ActiveRecord::Migration[5.2]
  def change
    create_table :availabilities do |t|
      t.string :day
      t.time :start_time
      t.time :end_time
    end
  end
end
