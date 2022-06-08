# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# Cleaning the database
puts "Cleaning the database..."
User.destroy_all
Feedback.destroy_all
Report.destroy_all

# Create teams users
real_users = []

puts "Create team user Riza..."
user = User.new
user.first-name = "Riza"
user.last_name = "Santoso"
user.email = "rizza.santoso@gmail.com"
user.country = "🇮🇩"
file = File.open(Rails.root.join("app/assets/images/riza.jpg"))
user.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
user.save
real_users << user.id

puts "Create team user Alex..."
user = User.new
user.first-name = "Alex"
user.last_name = "Stan"
user.email = "alex.stan@gmail.com"
user.country = "🇫🇷"
file = File.open(Rails.root.join("app/assets/images/alex.jpg"))
user.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
user.save
real_users << user.id


puts "Create team user Glen..."
user = User.new
user.first-name = "Glen"
user.last_name = "Smith"
user.email = "glen.smith@gmail.com"
user.country = "🇬🇧"
file = File.open(Rails.root.join("app/assets/images/glen.jpg"))
user.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
user.save
real_users << user.id

# Create random users
random_users = []
i = 0
10.times do
  i++
  puts "Create random user #{i}..." 
  user = User.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.email = "#{user.first_name}.#{user.last_name}@gmail.com"
  user.country = Faker::Nation.flag
  file = File.open(Rails.root.join(Faker::Avatar.image(slug: "my-own-slug", size: "50x50")))
  user.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
  user.save
  random_users << user.id
en

CATEGORIES = ["road accident", "mugging", "pickpocket", "sexual harrasment", "scams", "others"]
LOCAL_ADDRESS = ["Jalan Batu Mejan, Canggu, Kuta Utara, Canggu, Kec. Kuta Utara, Kabupaten Badung, Bali 80351", "Jl. Pantai Batu Bolong, Canggu, Kec. Kuta Utara, Kabupaten Badung, Bali", "Jl. Pantai Batu Mejan, Canggu, Kec. Kuta Utara, Kabupaten Badung, Bali 80361", "Jl. Pantai Batu Bolong No.168, Canggu, Kec. Kuta Utara, Bandung, Bali 80351", "Jl. Pantai Batu Bolong No.89x, Canggu, Kec. Kuta Utara, Kabupaten Badung, Bali"]

# Create our team users reports in a defined area, will be linked to team users for demo purpose
reports = []
i = 0
LOCAL_ADDRESS.each do |address|
  i++
  puts "Create local area report #{i}..."
  report = Report.new
  report.user_id = real_user[i % 4].id
  report.category = CATEGORIES.sample
  report.risk_level = [0,1].sample
  report.description = "This place is dangerous, run away!"
  report.address = address
  report.save
  reports << report
end

# Create world reports to display on main map, will be linked to random users
i = 0
random_users.each do |user|
  i++
  puts "Create world area report #{i}..."
  report = Report.new
  report.user_id = user.id
  report.category = CATEGORIES.sample
  report.risk_level = [0,1].sample
  report.description = "This place is dangerous, run away!"
  report.address = "*"
  report.lat = Faker::Address.latitude
  report.lon = Faker::Address.longitude
  report.save
  reports << report
end

# Create reviews for the real users reports
i = 0
reports.each do |report|
  i++
  puts "Create review #{i}..."
  feedback = Feedback.new
  feedback.user_id = real_users.sample
  feedback.comment = Faker::Lorem.sentence
  feedback.votes = [0, 1].sample
  feedback.report_id = report.id
end

puts "#{User.all.count} created!"
puts "#{Review.all.count} created!"
puts "#{Feedback.all.count} created!"
