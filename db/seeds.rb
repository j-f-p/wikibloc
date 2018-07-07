# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

# constants
nw = 24 # wikis
mps = ['fdsjkl','rewuio','vcxm,.']

# members are created manually with a simple password for testing

# standard members
User.create!(
  email: 'sy@example.com',
  password: mps[0],
  confirmed_at: Time.now
)

User.create!(
  email: 'ho@example.com',
  password: mps[0],
  confirmed_at: Time.now
)

User.create!(
  email: 'ty@example.com',
  password: mps[0],
  confirmed_at: Time.now
)

User.create!(
  email: 'jo@example.com',
  password: mps[0],
  confirmed_at: Time.now
)

User.create!(
  email: 'ed@example.com',
  password: mps[0],
  confirmed_at: Time.now
)

# premium members
User.create!(
  email: 'ben@example.com',
  password: mps[1],
  confirmed_at: Time.now,
  role: 'premium'
)

User.create!(
  email: 'ron@example.com',
  password: mps[1],
  confirmed_at: Time.now,
  role: 'premium'
)

# 1 admin
User.create!(
  email: 'casey@example.com',
  password: mps[2],
  confirmed_at: Time.now,
  role: 'admin'
)

users = User.all

# wikis are generated, some private
nw.times do
  wiki_user = users.sample
  wiki_private = false
  
  # if authorized, with 50% probability, assign wiki as private
  unless User.find(wiki_user.id).standard?
    wiki_private = [false,true].sample
  end
  
  Wiki.create!(
    user: wiki_user,
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    private: wiki_private
  )
end

puts "Seed finished"
puts "#{User.count} users created:"
puts "  #{User.where(role: :standard).count} standard"
puts "  #{User.where(role: :premium).count} premium"
puts "  1 admin"
puts "#{nw} wikis created:"
puts "  #{Wiki.where(private: true).count} private"
