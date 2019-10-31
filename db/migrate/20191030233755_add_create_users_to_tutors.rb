class AddCreateUsersToTutors < ActiveRecord::Migration[5.2]
  def change
    add_reference :tutors, :create_users, foreign_key: true
  end
end
