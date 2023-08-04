namespace :monthly_report do
  desc 'Generate and send the monthly expense report'
  task :generate_and_send_monthly_report => :environment do
    # Call the ExpenseReportService to generate and send the report
    ExpenseReportService.generate_and_send_monthly_report
  end
end