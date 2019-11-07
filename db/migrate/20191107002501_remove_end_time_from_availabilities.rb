class RemoveEndTimeFromAvailabilities < ActiveRecord::Migration[5.2]
  def change
    remove_column :availabilities, :end_time, :time
  end
end
