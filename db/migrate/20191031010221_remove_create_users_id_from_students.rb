class RemoveCreateUsersIdFromStudents < ActiveRecord::Migration[5.2]
  def change
    remove_column :students, :create_users_id, :integer
  end
end
