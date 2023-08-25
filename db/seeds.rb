# rubocop:disable all

require "faker"

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

PASSWORD = "Password#123"

# Create organizations
5.times do
  organization = Organization.create!(
    name: Faker::Company.name,
  )
  # Create admin users
  2.times do
    User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.unique.email,
      password: PASSWORD,
      password_confirmation: PASSWORD,
      organization:,
      is_admin?: true,
    )
  end

  # Create regular users
  3.times do
    User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.unique.email,
      password: PASSWORD,
      password_confirmation: PASSWORD,
      organization:,
    )
  end

  # Create categories
  3.times do
    category = organization.categories.create!(
      name: Faker::Commerce.department,
    )

    # Create sub-categories
    4.times do
      category.subcategories.create!(
        name: Faker::Commerce.product_name,
      )
    end
  end

  User.where(organization:).each do |user|
    Category.all.sample(5).each do |category|

      # Create budgets
      subcategory = category.subcategories.sample
      Budget.create!(
        user:,
        category:,
        subcategory:,
        amount: Faker::Number.between(from: 100, to: 1000),
        notes: Faker::Lorem.sentence,
        month: Faker::Number.between(from: 1, to: 12),
        year: Date.current.year,
      )

      # Create expenses
      subcategory = category.subcategories.sample
      status = Expense.statuses.keys.sample
      Expense.create!(
        user:,
        category:,
        subcategory:,
        date: Faker::Date.between(from: 6.months.ago, to: Date.current),
        amount: Faker::Number.between(from: 10, to: 100),
        notes: Faker::Lorem.sentence,
        status:,
        rejection_reason: status == "rejected" ? Faker::Lorem.sentence : nil,
        month: Faker::Number.between(from: 1, to: 12),
        year: Date.current.year,
      )
    end

    # Create wallets
    Wallet.create!(
      user:,
      amount: Faker::Number.between(from: 100, to: 1000),
      month: Faker::Number.between(from: 1, to: 12),
      year: Date.current.year,
    )
  end
end

Organization.all.sample(2).each do |organization|
  puts "Organization: #{organization.name}"
  staff_member = organization.users.where(is_admin?: false).sample
  puts "A sample staff member: #{staff_member.email}" if staff_member
  admin_user = organization.users.where(is_admin?: true).sample
  puts "A sample admin user: #{admin_user.email}" if admin_user
end

puts "Password for all the users is: #{PASSWORD}"
