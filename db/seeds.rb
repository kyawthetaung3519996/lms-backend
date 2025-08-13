# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
def create_role(name, is_default_admin)
  Role.where(
    name: name,
    is_default_admin: is_default_admin
  ).first_or_create!
end

def create_user(username, first_name, last_name, email, password)
  User.first_or_create(
    username: username,
    first_name: first_name,
    last_name: last_name,
    email: email,
    password: password,
    password_confirmation: password,
    role: Role.find_by(name: "Admin"),
  )
end

puts "create roles"
role1 = create_role("Admin", true)
role2 = create_role("User", false)


puts "create users"
admin1 = create_user("admin", "Admin", "User", "admin@gmail.com", "admin@1234")