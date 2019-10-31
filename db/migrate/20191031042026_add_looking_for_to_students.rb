class AddLookingForToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :looking_for, :integer
  end
end
