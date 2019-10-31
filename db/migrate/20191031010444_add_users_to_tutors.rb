class AddUsersToTutors < ActiveRecord::Migration[5.2]
  def change
    add_reference :tutors, :user, foreign_key: true
  end
end
