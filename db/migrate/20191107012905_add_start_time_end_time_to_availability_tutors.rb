class AddStartTimeEndTimeToAvailabilityTutors < ActiveRecord::Migration[5.2]
  def change
    add_column :availability_tutors, :start_time, :integer
    add_column :availability_tutors, :end_time, :integer
  end
end
