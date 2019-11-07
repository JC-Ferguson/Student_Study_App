class AddStartTimeToAvailabilities < ActiveRecord::Migration[5.2]
  def change
    add_column :availabilities, :start_time, :integer
  end
end
