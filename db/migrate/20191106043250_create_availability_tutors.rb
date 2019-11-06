class CreateAvailabilityTutors < ActiveRecord::Migration[5.2]
  def change
    create_table :availability_tutors do |t|

      t.integer :tutor_id
      t.integer :availability_id

      t.timestamps
    end
  end
end
