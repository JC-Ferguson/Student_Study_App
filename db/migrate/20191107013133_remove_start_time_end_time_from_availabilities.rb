class RemoveStartTimeEndTimeFromAvailabilities < ActiveRecord::Migration[5.2]
  def change
    remove_column :availabilities, :start_time, :integer
    remove_column :availabilities, :end_time, :integer
  end
end
