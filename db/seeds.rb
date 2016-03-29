require 'faker'

if Rails.env.development?
  User.destroy_all
  Wiki.destroy_all
end

# Creates random users

25.times do
  user = User.new(
    email: Faker::Internet.email,
    password: "password"
  )
  user.save!
end

users = User.all

# Creates random Wikis

50.times do
  Wiki.create!(
    user: users.sample,
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
  )
end

user = User.first
user.update_attributes!(
  email: "mullentucker@gmail.com",
  password: "password"
)

puts "Seeding finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
