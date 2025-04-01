# frozen_string_literal: true

# db/seeds.rb
require 'open-uri'

# Delete previous records for guests, services, and transactions
p 'Deleting previous records...'
Guest.destroy_all
Service.destroy_all
Transaction.destroy_all
p 'Previous records deleted.'

# Find or create the user by email
p 'Finding user...'
user = User.find_by(email: 'essai@essai.fr')

# If the user doesn't exist, create them (or you can handle this differently)
if user.nil?
  p 'User not found, creating user...'
  user = User.create!(email: 'essai@essai.fr', password: '11111111', name: 'Essai User') # Adjust as needed for your user model
else
  p 'User found.'
end

# Array of possible values for how_do_you_know_us
how_do_you_know_us_values = %w[google friend advise instagram]

# Create 20 guests only if guests are empty
if Guest.count.zero?
  p 'Creating new guests...'
  20.times do |i|
    guest = Guest.create!(
      name: Faker::Name.name, # Realistic full name
      firstname: Faker::Name.first_name, # Random first name
      email: Faker::Internet.email, # Realistic email
      phone: Faker::PhoneNumber.phone_number,  # Realistic phone number
      address: Faker::Address.street_address,  # Realistic street address
      zip_code: Faker::Address.zip_code, # Realistic zip code
      city: Faker::Address.city, # Realistic city
      country: Faker::Address.country, # Realistic country
      birthdate: Faker::Date.birthday(min_age: 18, max_age: 80), # Random birthdate
      how_do_you_know_us: how_do_you_know_us_values.sample, # Randomly selected value from the array
      notes: Faker::Lorem.sentence, # Realistic sentence for notes
      user_id: user.id # Assign the user to this guest
    )

    # Attach a fake photo (using a random image service like Lorem Picsum)
    guest.photo.attach(
      io: URI.open("https://randomuser.me/api/portraits/women/#{i + 1}.jpg"), # Dynamic portrait image for each guest
      filename: "profile_#{i + 1}.jpg", # Set filename for the photo
      content_type: 'image/jpg' # Set content type Set content typeet content type
    )

    p "Guest #{i + 1} created with a fake photo."
  end
  p 'Guests created.'
else
  p 'Guests already exist, skipping creation.'
end

# Create 20 lash-related services only if services are empty
if Service.count.zero?
  p 'Creating new services...'
  service_names = [
    'Classic Lash Extensions',
    'Volume Lash Extensions',
    'Hybrid Lash Extensions',
    'Russian Volume Lash Extensions',
    'Lash Lift & Tint',
    'Lash Tinting',
    'Mega Volume Lash Extensions',
    'Lash Refill (Classic)',
    'Lash Refill (Volume)',
    'Lash Removal',
    'Lash Touch-Up',
    'Lash Conditioning Treatment',
    'Lash Repair Treatment',
    'Eyelash Extension Removal',
    'Brow & Lash Combo (Lash Lift + Brow Tint)',
    'Lash & Brow Tint',
    'Volume Lash Full Set',
    'Lash Extension Full Set (Classic)',
    'Lash Extension Full Set (Hybrid)',
    'Lash Lift'
  ]

  20.times do |_i|
    Service.create!(
      name: service_names.sample, # Randomly select a lash-related service name
      price: Faker::Commerce.price(range: 50..200), # Random price for the service
      user_id: user.id # Assign the user to this service
    )
  end
  p 'Lash services created.'
else
  p 'Services already exist, skipping creation.'
end

# Create transactions only if there are guests and services available
if Guest.count.positive? && Service.count.positive?
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
      user_id: user.id
    )
    p "Transaction #{i + 1} created."
  end
else
  p 'Not enough guests or services to create transactions.'
end
