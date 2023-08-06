# frozen_string_literal: true

set :output, 'log/cron_log.log'

# Task for generating and sending monthly reports in production environment
every 1.month, at: 'start of the month', roles: [:app] do
  rake 'monthly_report:generate_and_send_monthly_report', environment: 'production'
end

# Task for generating and sending monthly reports in development environment
every 1.month, at: 'start of the month', roles: [:app] do
  rake "monthly_report:generate_and_send_monthly_report", environment: 'development'
end
