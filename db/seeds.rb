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

# Create sample Budgets
budgets = [
  { user_id: User.find_by(email: "user1@test.com").id, category_id: Category.find_by(name: "Travel Expense").id, subcategory_id: Subcategory.find_by(name: "Recruitment Drive").id, amount: 500.0, notes: "Recruitment drive expenses", month: Date.today },

  { user_id: User.find_by(email: "user1@test.com").id, category_id: Category.find_by(name: "Travel Expense").id, subcategory_id: Subcategory.find_by(name: "Client Visits").id, amount: 800.0, notes: "Client visits expenses", month: Date.today },

  { user_id: User.find_by(email: "user2@test.com").id, category_id: Category.find_by(name: "Event Expense").id, subcategory_id: Subcategory.find_by(name: "Birthday").id, amount: 200.0, notes: "Birthday celebration expenses", month: Date.today },

  { user_id: User.find_by(email: "user2@test.com").id, category_id: Category.find_by(name: "Event Expense").id, subcategory_id: Subcategory.find_by(name: "Annual Day").id, amount: 300.0, notes: "Annual day expenses", month: Date.today },

  { user_id: User.find_by(email: "user2@test.com").id, category_id: Category.find_by(name: "Goods Purchase").id, subcategory_id: Subcategory.find_by(name: "Food & Beverages").id, amount: 150.0, notes: "Food and beverages purchase", month: Date.today },

  { user_id: User.find_by(email: "user2@test.com").id, category_id: Category.find_by(name: "Goods Purchase").id, subcategory_id: Subcategory.find_by(name: "Stationeries").id, amount: 50.0, notes: "Stationery purchase", month: Date.today },
]

budgets.each do |budget|
  Budget.create(budget)
end

# Create sample Expense
# sample_expenses = [
#   { user: User.all.sample, sub_category: SubCategory.all.sample, date: Date.today, amount: 100, notes: "Sample expense 1" },
#   { user: User.all.sample, sub_category: SubCategory.all.sample, date: Date.today, amount: 200, notes: "Sample expense 2" },
#   { user: User.all.sample, sub_category: SubCategory.all.sample, date: Date.today, amount: 150, notes: "Sample expense 3" },
# ]
# sample_expenses.each do |expense|
#   Expense.create(expense)
# end

# puts "Seeding complete!"
