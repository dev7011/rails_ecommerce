class CreateAdminOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :customer_email
      t.string :address
      t.boolean :fulfilled
      t.integer :total_amount

      t.timestamps
    end

    add_index :orders, :customer_email
  end
end
