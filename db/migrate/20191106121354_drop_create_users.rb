class DropCreateUsers < ActiveRecord::Migration[5.2]
  def change
    drop_table :create_users do |t|
      t.string :name
      t.text :description
      t.integer :education_level
      t.timestamps
    end
  end
end
