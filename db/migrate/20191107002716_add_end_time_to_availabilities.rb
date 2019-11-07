class AddEndTimeToAvailabilities < ActiveRecord::Migration[5.2]
  def change
    add_column :availabilities, :end_time, :integer
  end
end
