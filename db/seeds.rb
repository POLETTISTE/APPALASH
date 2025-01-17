# frozen_string_literal: true

# db/seeds.rb

# Delete previous records for guests, services, and transactions
p 'Deleting previous records...'
Guest.destroy_all
Service.destroy_all
Transaction.destroy_all
p 'Previous records deleted.'
p 'Creating new records...'

# Array of possible values for how_do_you_know_us
how_do_you_know_us_values = %w[google friend advise instagram]

# Create 20 guests
20.times do |i|
  Guest.create!(
    name: "Guest #{i + 1}",
    firstname: "First #{i + 1}",
    email: "Guest#{i + 1}@example.com",
    phone: "555-1234#{i + 1}",
    address: "123 Main St #{i + 1}",
    zip_code: "12345#{i + 1}",
    city: "City #{i + 1}",
    country: "Country #{i + 1}",
    birthdate: Faker::Date.birthday(min_age: 18, max_age: 80),
    how_do_you_know_us: how_do_you_know_us_values.sample, # Randomly selected value
    notes: "Notes for guest #{i + 1}",
    user_id: 3
  )
end
p 'Guests created.'
p 'Creating new services...'

# Create 20 services
20.times do |i|
  Service.create!(
    name: "Service #{i + 1}",
    price: Faker::Commerce.price(range: 50..200),
    user_id: 3
  )
end
p 'Services created.'

p 'Creating new transactions...'

# Create 20 transactions
Guest.all.each_with_index do |guest, i|
  services = Service.all.sample(2) # Select two random services for each transaction
  total_price = services.sum(&:price)

  Transaction.create!(
    date: Faker::Date.backward(days: 30),
    guest: guest,
    services: services.map { |service| { name: service.name, price: service.price } },
    total_price: total_price,
    user_id: 3
  )
  p "Transaction #{i + 1} created."
end
