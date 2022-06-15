# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'open-uri'

######################################################
### DB CLEAINING
######################################################
puts "Cleaning the database..."
Feedback.destroy_all
Report.destroy_all
User.destroy_all

######################################################
### GLOBAL VARIABLES
######################################################
NBR_USERS = 7
NBR_WORLD_REPORTS = 100
MAX_REVIEWS = 5

LOCAL_ADDRESS = ["Canggu, Bali", "Ubud, Bali", "Denpasar, Bali", "Kuta, Bali", "31 Av. de la Bourdonnais, 75007 Paris, France", "20 Rue Jean Rey, 75015 Paris, France", "Pont de Bir-Hakeim, 75015 Paris, France", "12 Av. Rapp, 75007 Paris, France"].freeze

GENERIC_FEEDBACK = ["I totally feel the pain. I had the same experience when I was in Mexico last year.", "One of the reasons, there is so much crime is - the lack of Police, too much austerity. The chances of getting caught is virtually zero !", "It really makes me mad to read all of this", "This is disgusting behaviour!", "This person deserves to be in hell.", "That's just gross. What on earth gives someone the right to do that. Just how disgusting can that person be. It's absolutely unacceptable and it should never happen."]

######################################################
### USERS
######################################################
# Create teams users
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
file = File.open(Rails.root.join("app/assets/images/glen.png"))
user.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
user.save
real_users << user.id

# Create random users
random_users = []
# user_image = ["https://kitt.lewagon.com/placeholder/users/arthur-littm", "https://kitt.lewagon.com/placeholder/users/sarahlafer", "https://kitt.lewagon.com/placeholder/users/krokrob"].freeze
# user_image = ["https://kitt.lewagon.com/placeholder/users/sarahlafer"].freeze
# user_image = [image_tag("girl_1.jpg"), image_tag("girl_2.jpg"), image_tag("girl_3.jpg"), image_tag("girl_4.jpg"), image_tag("girl_5.jpg"), image_tag("girl_6.jpg"), image_tag("girl_7.jpg"), image_tag("girl_8.jpg")].sample
i = 0
NBR_USERS.times do
  puts "Create random user #{i + 1}/#{NBR_USERS}..."
  user = User.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.email = "#{user.first_name}.#{user.last_name}@gmail.com"
  user.password = "12345678"
  user.country = Faker::Nation.flag
  file = File.open(Rails.root.join("app/assets/images/girl_#{i + 1}.jpg"))
  #file = File.open(Rails.root.join(Faker::Avatar.image(slug: "my-own-slug", size: "50x50")))
  # file = File.open(Rails.root.join(image_tag user_image.sample ))
  # file = URI.open(user_image.sample)
  user.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
  user.save
  random_users << user.id
  i += 1
end

######################################################
### REPORTS
######################################################

# Create our local reports in a defined area (Paris and Canggu), will be linked to team users for demo purpose
reports = []
exclusion_reports = []
i = 0
LOCAL_ADDRESS.each do |address|
  recent_report = rand(2)
  i += 1
  puts "Create local area report #{i}..."
  report = Report.new
  report.user_id = random_users[i % NBR_USERS]
  report.category = Report::CATEGORIES.sample
  report.risk_level = rand(3)
  # Below the 2 reports tht will be pitched (Canggu and Kuta)
  if address.include?('Canggu')
    report.description = "I was watching the sunset at Batu Bolong Beach when a balding man carrying a can of beer approached me. The man was very bubbly and had an English accent. Although he seemed quite lovely at first, things quickly got out of hand. I finally managed to push him away and ran from him. Glad I was able to bend his fingers, so if you spot a balding British man with a beard and a broken finger, please be aware."
    report.category = "sexual harrasment"
    file = File.open(Rails.root.join("app/assets/images/canggu_report.jpg"))
    report.photos.attach(io: file, filename: 'nes.png', content_type: 'image/png')
  elsif address.include?('Kuta')
    report.description = "I was walking along Kuta Street with my purse in hand. Unexpectedly, a bald Caucasian man on a scooter snatched my purse. I was shocked and really disappointed to lose my passport, credit cards, and a few thousand dollars."
    report.category = "robbery"
    file = File.open(Rails.root.join("app/assets/images/kuta_report.jpg"))
    report.photos.attach(io: file, filename: 'nes.png', content_type: 'image/png')
  else
    report.description = "This place is dangerous, run away!"
  end
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
NBR_WORLD_REPORTS.times do
  recent_report = rand(2)
  i += 1
  puts "Create world area report #{i}/#{NBR_WORLD_REPORTS}..."
  report = Report.new
  report.user_id = random_users[i % NBR_USERS]
  report.category = Report::CATEGORIES.sample
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
  rand(0..MAX_REVIEWS).times do
    i += 1
    puts "Create review #{i}..."
    feedback = Feedback.new
    feedback.user_id = random_users.sample
    feedback.comment = GENERIC_FEEDBACK.sample
    feedback.votes = [0, 1].sample
    feedback.report_id = report.id
    feedback.save
  end
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
