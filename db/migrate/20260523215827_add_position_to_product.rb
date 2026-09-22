class AddPositionToProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :position, :integer
    Product.order(:name).each.with_index(1) do |product, index|
      product.update_column(:position, index)
    end
  end
end
