# frozen_string_literal: true

PASSWORD = '123'

# Create organizations
organizations = [
  { name: 'Organization 1' }
]
organizations.each do |organization|
  Organization.create(organization)
end

# Create admin users
admin_users = [
  {
    name: 'Admin 1',
    email: 'admin1@test.com',
    password: PASSWORD,
    password_confirmation: PASSWORD,
    organization_id: 1,
    is_admin?: true
  },
  {
    name: 'Admin 2',
    email: 'admin2@test.com',
    password: PASSWORD,
    password_confirmation: PASSWORD,
    organization_id: 1,
    is_admin?: true
  }
]
admin_users.each do |admin_user|
  User.create(admin_user)
end

# Create regular users
users = [
  {
    name: 'User 1',
    email: 'user1@test.com',
    password: PASSWORD,
    password_confirmation: PASSWORD,
    organization_id: 1
  },
  {
    name: 'User 2',
    email: 'user2@test.com',
    password: PASSWORD,
    password_confirmation: PASSWORD,
    organization_id: 1
  }
]
users.each do |user|
  User.create(user)
end

# Create categories
categories = [
  { name: 'Travel Expense' },
  { name: 'Event Expense' },
  { name: 'Goods Purchase' }
]
categories.each do |category|
  Category.create(category)
end

# Create sub-categories
subcategories = [
  { name: 'Recruitment Drive', category_id: Category.find_by(name: 'Travel Expense')[:id] },
  { name: 'Client Visits', category_id: Category.find_by(name: 'Travel Expense')[:id] },
  { name: 'Conference', category_id: Category.find_by(name: 'Travel Expense')[:id] },
  { name: 'Exhibitions', category_id: Category.find_by(name: 'Travel Expense')[:id] },
  { name: 'Birthday', category_id: Category.find_by(name: 'Event Expense')[:id] },
  { name: 'Annual Day', category_id: Category.find_by(name: 'Event Expense')[:id] },
  { name: 'Festivals', category_id: Category.find_by(name: 'Event Expense')[:id] },
  { name: 'Food & Beverages', category_id: Category.find_by(name: 'Goods Purchase')[:id] },
  { name: 'Stationeries', category_id: Category.find_by(name: 'Goods Purchase')[:id] },
  { name: 'Cleaning', category_id: Category.find_by(name: 'Goods Purchase')[:id] },
  { name: 'Electronics Accessories', category_id: Category.find_by(name: 'Goods Purchase')[:id] }
]
subcategories.each do |subcategory|
  Subcategory.create(subcategory)
end

# Create sample budgets
budgets = [
  {
    user_id: User.find_by(email: 'user1@test.com').id,
    category_id: Category.find_by(name: 'Travel Expense').id,
    subcategory_id: Subcategory.find_by(name: 'Recruitment Drive').id,
    amount: 500.0,
    notes: 'Recruitment drive expenses',
    month: 1,
    year: Date.current.year
  },
  {
    user_id: User.find_by(email: 'user1@test.com').id,
    category_id: Category.find_by(name: 'Travel Expense').id,
    subcategory_id: Subcategory.find_by(name: 'Client Visits').id,
    amount: 800.0,
    notes: 'Client visits expenses',
    month: 2,
    year: Date.current.year
  },
  {
    user_id: User.find_by(email: 'user2@test.com').id,
    category_id: Category.find_by(name: 'Event Expense').id,
    subcategory_id: Subcategory.find_by(name: 'Birthday').id,
    amount: 200.0,
    notes: 'Birthday celebration expenses',
    month: 2,
    year: Date.current.year
  },
  {
    user_id: User.find_by(email: 'user2@test.com').id,
    category_id: Category.find_by(name: 'Event Expense').id,
    subcategory_id: Subcategory.find_by(name: 'Annual Day').id,
    amount: 300.0,
    notes: 'Annual day expenses',
    month: 1,
    year: Date.current.year
  },
  {
    user_id: User.find_by(email: 'user2@test.com').id,
    category_id: Category.find_by(name: 'Goods Purchase').id,
    subcategory_id: Subcategory.find_by(name: 'Food & Beverages').id,
    amount: 150.0,
    notes: 'Food and beverages purchase',
    month: 5,
    year: Date.current.year
  },
  {
    user_id: User.find_by(email: 'user2@test.com').id,
    category_id: Category.find_by(name: 'Goods Purchase').id,
    subcategory_id: Subcategory.find_by(name: 'Stationeries').id,
    amount: 50.0,
    notes: 'Stationery purchase',
    month: 3,
    year: Date.current.year
  }
]
budgets.each do |budget|
  Budget.create(budget)
end

# Create sample expenses
expenses = [
  {
    user_id: User.find_by(email: 'user1@test.com').id,
    category_id: Category.find_by(name: 'Travel Expense').id,
    subcategory_id: Subcategory.find_by(name: 'Recruitment Drive').id,
    date: Date.today,
    amount: 100.0,
    notes: 'Expense 1',
    status: 0,
    month: Date.current.month,
    year: Date.current.year
  },
  {
    user_id: User.find_by(email: 'user1@test.com').id,
    category_id: Category.find_by(name: 'Travel Expense').id,
    subcategory_id: Subcategory.find_by(name: 'Client Visits').id,
    date: Date.today,
    amount: 200.0,
    notes: 'Expense 2',
    status: 1,
    month: Date.current.month,
    year: Date.current.year
  },
  {
    user_id: User.find_by(email: 'user2@test.com').id,
    category_id: Category.find_by(name: 'Event Expense').id,
    subcategory_id: Subcategory.find_by(name: 'Birthday').id,
    date: Date.today,
    amount: 150.0,
    notes: 'Expense 3',
    status: 2,
    month: Date.current.month,
    year: Date.current.year
  },
  {
    user_id: User.find_by(email: 'user2@test.com').id,
    category_id: Category.find_by(name: 'Event Expense').id,
    subcategory_id: Subcategory.find_by(name: 'Annual Day').id,
    date: Date.today,
    amount: 300.0,
    notes: 'Expense 4',
    status: 0,
    month: Date.current.month,
    year: Date.current.year
  },
  {
    user_id: User.find_by(email: 'user2@test.com').id,
    category_id: Category.find_by(name: 'Goods Purchase').id,
    subcategory_id: Subcategory.find_by(name: 'Food & Beverages').id,
    date: Date.today,
    amount: 50.0,
    notes: 'Expense 5',
    status: 1,
    month: Date.current.month,
    year: Date.current.year
  }
]
expenses.each do |expense|
  Expense.create(expense)
end

# Create sample wallets
wallets = [
  {
    user_id: User.find_by(email: 'user1@test.com').id,
    amount: 500.0,
    month: Date.current.month,
    year: Date.current.year
  },
  {
    user_id: User.find_by(email: 'user2@test.com').id,
    amount: 800.0,
    month: Date.current.month,
    year: Date.current.year
  }
]
wallets.each do |wallet|
  Wallet.create(wallet)
end
