# frozen_string_literal: true

require 'prawn'
require 'prawn/table'

# Service class for generating and sending monthly expense reports.
class ExpenseReportService
  class << self
    def generate_and_send_monthly_report
      Organization.find_each do |organization|
        generate_and_send_report_for_organization(organization)
      end
    end

    private

    def generate_and_send_report_for_organization(organization)
      users = User.get_non_admin_users(organization.id)
      users.find_each(batch_size: 100) do |user|
        pdf_filename = generate_pdf(Expense.get_approved_expenses(user), user)
        send_report_email(user, pdf_filename)
        delete_temp_pdf(pdf_filename)
      end
    end

    def generate_pdf(expenses, user)
      pdf = Prawn::Document.new
      add_logo(pdf)
      add_report_title(pdf)
      add_expense_table(pdf, expenses)
      pdf_filename = generate_pdf_filename(user)
      pdf.render_file(pdf_filename)
      pdf_filename
    end

    def add_logo(pdf)
      logo_path = Rails.root.join('app', 'assets', 'images', 'logo-full.png')
      pdf.image logo_path, position: :center, width: 200 if File.exist?(logo_path)
      pdf.move_down(20)
    end

    def add_report_title(pdf)
      pdf.text 'Monthly Expense Report', size: 18, align: :center
      pdf.move_down(10)
    end

    def add_expense_table(pdf, expenses)
      table_data = expense_table_data(expenses)
      pdf.table(table_data) do
        row(0).font_style = :bold
        self.row_colors = %w[DDDDDD FFFFFF]
        self.header = true
      end
    end

    def expense_table_data(expenses)
      [%w[Category Amount Date]] +
        expenses.map { |expense| [expense.category.name, expense.amount, expense.date] }
    end

    def generate_pdf_filename(user)
      "#{user[:first_name]}_monthly_expense_report.pdf"
    end

    def send_report_email(user, pdf_filename)
      UserMailer.with(user:, pdf_filename:).monthly_expense_report.deliver_now
    end

    def delete_temp_pdf(pdf_filename)
      File.delete(pdf_filename)
    end
  end
end
