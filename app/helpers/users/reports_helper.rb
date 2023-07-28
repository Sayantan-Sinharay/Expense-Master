# frozen_string_literal: true

module Users
  # Helper module for the ReportsController in the user panel.
  module ReportsHelper
    def yearly_report(user)
      User.year_wise_expenses(user)
    end

    def category_wise_report(user)
      category_wise_expenses_hash = {}

      User.category_wise_expenses(user).each do |category_id, amount|
        category_name = Category.find_by(id: category_id)&.name
        category_wise_expenses_hash[category_name] = amount if category_name
      end

      category_wise_expenses_hash
    end
  end
end
