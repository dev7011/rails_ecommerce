class Order < ApplicationRecord
  has_many :products, through: :order_items
  has_many :order_items, dependent: :restrict_with_error
end
