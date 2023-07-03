# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PASSWORD = "123"

# Create organizations
organizations = [
  { name: "Organization 1" },
]
organizations.each do |organization|
  Organization.create(organization)
end

# Create admin users
admin_users = [
  { name: "Admin 1", email: "admin1@test.com", password: PASSWORD, password_confirmation: PASSWORD, organization_id: 1, is_admin?: true },
  { name: "Admin 2", email: "admin2@test.com", password: PASSWORD, password_confirmation: PASSWORD, organization_id: 1, is_admin?: true },
]
admin_users.each do |admin_user|
  User.create(admin_user)
end

users = [
  { name: "User 1", email: "user1@test.com", password: PASSWORD, password_confirmation: PASSWORD, organization_id: 1 },
  { name: "User 2", email: "user2@test.com", password: PASSWORD, password_confirmation: PASSWORD, organization_id: 1 },
]

users.each do |user|
  User.create(user)
end

# # Assign users to organizations
# User.all.each do |user|
#   organization = Organization.all.sample
#   user.update(organization: organization)
# end

# Create categories
categories = [
  { name: "Travel Expense" },
  { name: "Event Expense" },
  { name: "Goods Purchase" },
]
categories.each do |category|
  Category.create(category)
end

# Create sub-categories
sub_categories = [
  { name: "Recruitment Drive", category_id: Category.find_by(name: "Travel Expense")[:id] },
  { name: "Client Visits", category_id: Category.find_by(name: "Travel Expense")[:id] },
  { name: "Conference", category_id: Category.find_by(name: "Travel Expense")[:id] },
  { name: "Exhibitions", category_id: Category.find_by(name: "Travel Expense")[:id] },
  { name: "Birthday", category_id: Category.find_by(name: "Event Expense")[:id] },
  { name: "Annual Day", category_id: Category.find_by(name: "Event Expense")[:id] },
  { name: "Festivals", category_id: Category.find_by(name: "Event Expense")[:id] },
  { name: "Food & Beverages", category_id: Category.find_by(name: "Goods Purchase")[:id] },
  { name: "Stationeries", category_id: Category.find_by(name: "Goods Purchase")[:id] },
  { name: "Cleaning", category_id: Category.find_by(name: "Goods Purchase")[:id] },
  { name: "Electronics Accessories", category_id: Category.find_by(name: "Goods Purchase")[:id] },
]
sub_categories.each do |sub_category|
  Subcategory.create(sub_category)
end

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
