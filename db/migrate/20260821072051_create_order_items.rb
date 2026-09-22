class CreateOrderItems < ActiveRecord::Migration[7.1]
  def change
    create_table :order_items do |t|
      t.references :product, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.integer :quantity, null: false, default: 1
      t.integer :unit_price, null: false
      t.string :size
      t.integer :subtotal, null: false

      t.timestamps
    end

    add_index :order_items, %i[order_id product_id]
  end
end
