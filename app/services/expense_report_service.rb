# frozen_string_literal: true

require 'prawn'
require 'prawn/table'

class ExpenseReportService
  def self.generate_and_send_monthly_report
    Organization.all.each do |organization|
      users = User.get_non_admin_users(organization.id) # Use organization.id instead of organization[:id]
      users.each do |user|
        pdf_filename = generate_pdf(Expense.get_approved_expenses(user), user) # Store the PDF object
        UserMailer.with(user: user, pdf_filename: pdf_filename).monthly_expense_report.deliver_now
        File.delete(pdf_filename)
      end
    end
  end

  private

  def self.generate_pdf(expenses, user)
    pdf = Prawn::Document.new

    # Add logo from assets folder
    logo_path = Rails.root.join('app', 'assets', 'images', 'logo-full.png')
    pdf.image logo_path, position: :center, width: 200 if File.exist?(logo_path)

    pdf.move_down(20)
    pdf.text 'Monthly Expense Report', size: 18, align: :center
    pdf.move_down(10)

    # Table to display expenses
    table_data = expense_table_data(expenses)
    pdf.table(table_data) do
      row(0).font_style = :bold
      self.row_colors = %w[DDDDDD FFFFFF]
      self.header = true
    end
    
    pdf_filename = "#{user[:first_name]}_monthly_expense_report.pdf"
    pdf.render_file(pdf_filename)

    pdf_filename
  end

  def self.expense_table_data(expenses)
    table_data = [['Category', 'Amount', 'Date']]
    expenses.each do |expense|
      table_data.append([expense.category.name, expense.amount, expense.date])
    end
    table_data
  end
end
