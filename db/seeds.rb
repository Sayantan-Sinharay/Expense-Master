# rubocop:disable all

require 'faker'

# Clear existing data
ActiveStorage::Attachment.destroy_all
Budget.destroy_all
Category.destroy_all
Expense.destroy_all
Notification.destroy_all
Organization.destroy_all
Subcategory.destroy_all
User.destroy_all
Wallet.destroy_all

PASSWORD = 'Password#123'

# Create organizations
5.times do
  organization = Organization.create!(
    name: Faker::Company.name
  )
  puts "Created organization #{organization.name}"

  # Create admin users
  2.times do
    admin_user = User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.unique.email,
      password: PASSWORD,
      password_confirmation: PASSWORD,
      organization:,
      is_admin?: true
    )
    puts "Created admin user #{admin_user.email}"
  end

  # Create regular users
  3.times do
    user = User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.unique.email,
      password: PASSWORD,
      password_confirmation: PASSWORD,
      organization:
    )
    puts "Created user #{user.email}"
  end

  # Create categories
  3.times do
    category = organization.categories.create!(
      name: Faker::Commerce.department
    )
    puts "Created category #{category.name}"

    # Create sub-categories
    4.times do
      subcategory = category.subcategories.create!(
        name: Faker::Commerce.product_name
      )
      puts "Created subcategory #{subcategory.name}"
    end
  end

  # Create budgets
  User.where(organization:).each do |user|
    Category.all.sample(5).each do |category|
      subcategory = category.subcategories.sample

      Budget.create!(
        user:,
        category:,
        subcategory:,
        amount: Faker::Number.between(from: 100, to: 1000),
        notes: Faker::Lorem.sentence,
        month: Faker::Number.between(from: 1, to: 12),
        year: Date.current.year
      )
      subcategory = category.subcategories.sample
      status = Expense.statuses.keys.sample
      # Create expenses
      Expense.create!(
        user:,
        category:,
        subcategory:,
        date: Faker::Date.between(from: 6.months.ago, to: Date.current),
        amount: Faker::Number.between(from: 10, to: 100),
        notes: Faker::Lorem.sentence,
        status: ,
        rejection_reason: status == "rejected" ? Faker::Lorem.sentence : nil,
        month: Faker::Number.between(from: 1, to: 12),
        year: Date.current.year
      )
    end
    # Create wallets
    Wallet.create!(
      user:,
      amount: Faker::Number.between(from: 100, to: 1000),
      month: Faker::Number.between(from: 1, to: 12),
      year: Date.current.year
    )
  end


end

puts "A sample admin user: #{Organization.first.users.where(is_admin?: true).first.email}"
puts "A sample staff member: #{Organization.first.users.where(is_admin?: false).first.email}"
