# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

######################################################
### DB CLEAINING
######################################################
puts "Cleaning the database..."
Feedback.destroy_all
Report.destroy_all
User.destroy_all

######################################################
### USERS
######################################################
# Create teams users
NBR_USERS = 100

real_users = []

puts "Create team user Riza..."
user = User.new
user.first_name = "Riza"
user.last_name = "Santoso"
user.email = "rizza.santoso@gmail.com"
user.password = "12345678"
user.country = "🇮🇩"
file = File.open(Rails.root.join("app/assets/images/riza.png"))
user.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
user.save
real_users << user.id

puts "Create team user Alex..."
user = User.new
user.first_name = "Alex"
user.last_name = "Stan"
user.email = "alex.stan@gmail.com"
user.password = "12345678"
user.country = "🇫🇷"
file = File.open(Rails.root.join("app/assets/images/alex.jpg"))
user.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
user.save
real_users << user.id


puts "Create team user Glen..."
user = User.new
user.first_name = "Glen"
user.last_name = "Smith"
user.email = "glen.smith@gmail.com"
user.password = "12345678"
user.country = "🇬🇧"
file = File.open(Rails.root.join("app/assets/images/glen.jpg"))
user.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
user.save
real_users << user.id

# Create random users
random_users = []
i = 0
NBR_USERS.times do
  puts "Create random user #{i + 1}/#{NBR_USERS}..."
  user = User.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.email = "#{user.first_name}.#{user.last_name}@gmail.com"
  user.password = "12345678"
  user.country = Faker::Nation.flag
  # file = File.open(Rails.root.join(Faker::Avatar.image(slug: "my-own-slug", size: "50x50")))
  # user.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
  user.save
  random_users << user.id
  i += 1
end

######################################################
### REPORTS
######################################################
CATEGORIES = ["road accident", "mugging", "pickpocket", "sexual harrasment", "scams", "others"]
LOCAL_ADDRESS = ["Canggu, Bali", "Ubud, Bali", "Denpasar, Bali", "Kuta, Bali", "31 Av. de la Bourdonnais, 75007 Paris, France", "20 Rue Jean Rey, 75015 Paris, France", "Pont de Bir-Hakeim, 75015 Paris, France", "12 Av. Rapp, 75007 Paris, France"].freeze

# Create our team users reports in a defined area, will be linked to team users for demo purpose
reports = []
i = 0
LOCAL_ADDRESS.each do |address|
  recent_report = rand(2)
  i += 1
  puts "Create local area report #{i}..."
  report = Report.new
  report.user_id = real_users[i % 3]
  report.category = CATEGORIES.sample
  report.risk_level = rand(3)
  report.description = "This place is dangerous, run away!"
  if recent_report == 0
    # Report < 4 hours
    shift = rand(14400) # secs
    report.report_date_time = Time.now - shift
  else
    # Report > 4 hours and < 48 hours
    shift = rand(14400..172800)
    report.report_date_time = Time.now - shift
  end
  report.address = address
  report.save!
  reports << report
end

# Create world reports to display on main map, will be linked to random users
WORLD = { europe_west:    {lat: (46.5..0.0), long: (50.8..30.0)},
          europe_est:     {lat: (45.0..59.0), long: (28.0..66.0)},
          north_america:  {lat: (33.0..47.0), long: (-123.0..-80.0)},
          south_america:  {lat: (-30.0..-5.0), long: (-69.0..-50.0)},
          africa:         {lat: (-23.5..15.0), long: (31.5..35.5)},
          australia:      {lat: (-33.0..-18.2), long: (122.3..151.5)},
          big_china:      {lat: (23.19..50.8), long: (60.9..115.54)}
}.freeze
i = 0
random_users.each do |user|
  recent_report = rand(2)
  i += 1
  puts "Create world area report #{i}/#{NBR_USERS}..."
  report = Report.new
  report.user_id = user
  report.category = CATEGORIES.sample
  report.risk_level = rand(3)
  report.description = "This place is dangerous, run away!"
  if recent_report == 0
    # Report < 4 hours
    shift = rand(14400) # secs
    report.report_date_time = Time.now - shift
  else
    # Report > 4 hours and < 48 hours
    shift = rand(14400..172800)
    report.report_date_time = Time.now - shift
  end
  report.address = Faker::Address.full_address
  continent = WORLD.keys.sample
  report.longitude = rand(WORLD[continent][:long])
  report.latitude = rand(WORLD[continent][:lat])
  report.save!
  reports << report
end

######################################################
### FEEDBACKS
######################################################
# Create reviews for the real users reports
i = 0
reports.each do |report|
  i += 1
  puts "Create review #{i}/#{NBR_USERS}..."
  feedback = Feedback.new
  feedback.user_id = real_users.sample
  feedback.comment = Faker::Lorem.sentence
  feedback.votes = [0, 1].sample
  feedback.report_id = report.id
  feedback.save
end

puts "#{User.all.count} users created!"
puts "#{Report.all.count} reports created!"
puts "#{Feedback.all.count} feedbacks created!"

# EUROPE WEST
#   50.8, 0.0     -> 46.5, 30.0
# EUROPE EST
#   59.0, 28      -> 45.0 -> 66.0
# NORTH AMERICA
#   47.0, -123.0  -> 33.0, -80.0
# SOUTH AMERCIA
#   -5.0, -69.0   -> -30.0, -50.0
# AFRICA
#   31.5, 15.0    -> -23.7, 35.5
# AUSTRALIA
#   -18.2, 122.3   -> -33.0, 151,5
# CHINA
#   50.8, 60.9    -> 23.19, 115.54
