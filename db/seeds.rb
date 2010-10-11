# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Create some users
User.delete_all
user = User.create!(:email => "myrlund@gmail.com", :password => "passord")

# Create some lists
List.delete_all
Task.delete_all
lists = []
7.times do |n|
  list = List.create!(:name => Faker::Company.catch_phrase, :description => Faker::Lorem.paragraph, :user => user)
  
  # Generate some tasks for each list
  (5 + rand(20)).times do
    t = Task.new(:text => Faker::Company.catch_phrase, :list => list)
    t.done = 1 + rand(n) == 1
    t.save
  end
end

# Generate default roles
Role.delete_all
Role.create!(:name => "Admin", :description => "Site administrator")
