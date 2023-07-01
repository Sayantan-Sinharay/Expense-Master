# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create admin users
# admin_users = [
#   { name: "Admin 1", email: "admin1@example.com", password: "admin1password", role: :admin },
#   { name: "Admin 2", email: "admin2@example.com", password: "admin2password", role: :admin },
# ]
# admin_users.each do |admin_user|
#   User.create(admin_user)
# end

# # Create organizations
# organizations = [
#   { name: "Organization 1" },
#   { name: "Organization 2" },
# ]
# organizations.each do |organization|
#   Organization.create(organization)
# end

# # Assign users to organizations
# User.all.each do |user|
#   organization = Organization.all.sample
#   user.update(organization: organization)
# end

# # Create categories
# categories = [
#   { name: "Travel Expense" },
#   { name: "Event Expense" },
#   { name: "Goods Purchase" },
# ]
# categories.each do |category|
#   Category.create(category)
# end

# # Create sub-categories
# sub_categories = [
#   { name: "Recruitment Drive", category: Category.find_by(name: "Travel Expense") },
#   { name: "Client Visits", category: Category.find_by(name: "Travel Expense") },
#   { name: "Conference", category: Category.find_by(name: "Travel Expense") },
#   { name: "Exhibitions", category: Category.find_by(name: "Travel Expense") },
#   { name: "Birthday", category: Category.find_by(name: "Event Expense") },
#   { name: "Annual Day", category: Category.find_by(name: "Event Expense") },
#   { name: "Festivals", category: Category.find_by(name: "Event Expense") },
#   { name: "Food & Beverages", category: Category.find_by(name: "Goods Purchase") },
#   { name: "Stationeries", category: Category.find_by(name: "Goods Purchase") },
#   { name: "Cleaning", category: Category.find_by(name: "Goods Purchase") },
#   { name: "Electronics Accessories", category: Category.find_by(name: "Goods Purchase") },
# ]
# sub_categories.each do |sub_category|
#   SubCategory.create(sub_category)
# end

# # Create sample expenses
# sample_expenses = [
#   { user: User.all.sample, sub_category: SubCategory.all.sample, date: Date.today, amount: 100, notes: "Sample expense 1" },
#   { user: User.all.sample, sub_category: SubCategory.all.sample, date: Date.today, amount: 200, notes: "Sample expense 2" },
#   { user: User.all.sample, sub_category: SubCategory.all.sample, date: Date.today, amount: 150, notes: "Sample expense 3" },
# ]
# sample_expenses.each do |expense|
#   Expense.create(expense)
# end

# puts "Seeding complete!"

4.times do |i|
  User.create(name: "User#{i}", email: "user#{i}@example.com", password: "", password_confirmation: "", organization_id: 1, is_admin: if i % 2 == 0 then true else false end)
end
