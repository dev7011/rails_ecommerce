class Order < ApplicationRecord
  has_many :products, through: :order_items
  has_many :order_items, dependent: :restrict_with_error

  accepts_nested_attributes_for :order_items, allow_destroy: true
end
