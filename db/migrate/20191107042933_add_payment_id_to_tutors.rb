class AddPaymentIdToTutors < ActiveRecord::Migration[5.2]
  def change
    add_column :tutors, :payment_id, :string
  end
end
