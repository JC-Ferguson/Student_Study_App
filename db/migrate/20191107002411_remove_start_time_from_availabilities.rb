class RemoveStartTimeFromAvailabilities < ActiveRecord::Migration[5.2]
  def change
    remove_column :availabilities, :start_time, :time
  end
end
