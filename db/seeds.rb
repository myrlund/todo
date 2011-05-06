# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Generate default roles
Role.delete_all
Role.create!(:name => "Admin", :description => "Site administrator")
Role.create!(:name => "Stalker", :description => "Can read everything")
