class AddEducationLevelToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :education_level, :integer
  end
end
