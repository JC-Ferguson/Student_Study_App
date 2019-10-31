class AddCreateUsersToStudents < ActiveRecord::Migration[5.2]
  def change
    add_reference :students, :create_users, foreign_key: true
  end
end
