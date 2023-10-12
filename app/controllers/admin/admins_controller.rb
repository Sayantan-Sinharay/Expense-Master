# frozen_string_literal: true

module Admin
  # Controller for managing administrators in the admin panel.
  class AdminsController < ApplicationController
    before_action :require_login
    before_action :authenticate_admin

    # Redirects to the admin dashboards path
    def index
      redirect_to admin_dashboards_path
    end
  end
end
