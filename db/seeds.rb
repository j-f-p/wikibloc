# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

# clear the db without reloading schema
User.destroy_all
Wiki.destroy_all
Collaborator.destroy_all

# reset ids, seq = 0 results in a 1-based id sequence
case ActiveRecord::Base.connection.adapter_name
  when 'SQLite'
    ActiveRecord::Base.connection.execute(
      "UPDATE sqlite_sequence SET seq = 0 WHERE name = 'users';")
    ActiveRecord::Base.connection.execute(
      "UPDATE sqlite_sequence SET seq = 0 WHERE name = 'wikis';")
    ActiveRecord::Base.connection.execute(
      "UPDATE sqlite_sequence SET seq = 0 WHERE name = 'collaborators';")
  when 'PostgreSQL'
    ActiveRecord::Base.connection.reset_pk_sequence!('users')
    ActiveRecord::Base.connection.reset_pk_sequence!('wikis')
    ActiveRecord::Base.connection.reset_pk_sequence!('collaborators')
else 
    raise "Task not implemented for this DB adapter"
end

# constants
nw = 24 # wikis
nc = 4 # collaborations
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

user_ids = User.pluck(:id)

# wikis are generated, some private
nw.times do
  wiki_user_id = user_ids.sample
  wiki_private = false
  
  # if authorized, with 2/3 probability, assign wiki as private
  unless User.find(wiki_user_id).standard?
    wiki_private = [false,true,true].sample
  end
  
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    private: wiki_private,
    user: User.find(wiki_user_id)
  )
end

# collaborator assignments on some private wikis
private_wiki_ids = Wiki.where(private: true).pluck(:id)
ca_space = user_ids.product(private_wiki_ids).shuffle # randomizes pop below

nc.times do
  ca = ca_space.pop # so that every collaborator assignment is unique
  Collaborator.create!(
    user_id: ca[0],
    wiki_id: ca[1]
  )
end

puts "Seed finished"
puts "#{User.count} users created:"
puts "  #{User.where(role: :standard).count} standard"
puts "  #{User.where(role: :premium).count} premium"
puts "  1 admin"
puts "#{nw} wikis created:"
puts "  #{Wiki.where(private: true).count} private"
puts "#{nc} collaborator assignments created"
