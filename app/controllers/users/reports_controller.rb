# frozen_string_literal: true

module Users
  # Controller for managing reports for users.
  class ReportsController < ApplicationController
    before_action :authenticate_user
    include Users::ReportsHelper
    def index
      @yearly_data = yearly_report(Current.user)
      @category_data = category_wise_report(Current.user)
    end
  end
end
