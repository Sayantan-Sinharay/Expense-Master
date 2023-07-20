# frozen_string_literal: true

module Admin
  # Controller for managing administrators in the admin panel.
  class AdminsController < ApplicationController
    def index
      redirect_to admin_dashboards_path
    end
  end
end
