# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

if Admin.count.zero?
  Admin.create(email: "tnle7011@gmail.com", password: "123456", password_confirmation: "123456")
end


if Category.count.zero?
  (1..10).each do |i|
    Category.create(
      name: "#{Faker::Commerce.department} #{i}",
      description: Faker::Lorem.sentence
    )
  end
end

if Product.count.zero?
  (1..50).each do |i|
    Product.create(
      name: "#{Faker::Commerce.department} #{i}",
      description: Faker::Lorem.sentence,
      price: Faker::Commerce.price(range: 10..100.0),
      category: Category.all.sample
    )
  end
end

if Order.count.zero?
  (1..20).each do
    order = Order.create(
      address: Faker::Address.full_address,
      customer_email: Faker::Internet.email,
      total_amount: Faker::Number.number(digits: 4),
      fulfilled: [true, false].sample,
      created_at: rand(1.week.ago..Time.zone.now)
    )

    # Add random products to the order
    products = Product.all.sample(rand(1..5))
    products.each do |product|
      unit_price = Faker::Number.number(digits: 3)
      quantity = rand(1..3)
      subtotal = unit_price * quantity

      OrderItem.create(
        order: order,
        product: product,
        quantity: quantity,
        unit_price: unit_price,
        subtotal: subtotal
      )
    end
  end
end
