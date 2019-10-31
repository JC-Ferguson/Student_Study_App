class RemoveCreateUsersIdFromTutors < ActiveRecord::Migration[5.2]
  def change
    remove_column :tutors, :create_users_id, :integer
  end
end
