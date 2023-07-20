# frozen_string_literal: true

# HomesController handles home-related actions.
class HomesController < ApplicationController
  # Home page action: Redirects the user to the appropriate path based on their role.
  # If a user is logged in, it checks whether they are an admin or a regular user
  # and redirects accordingly. If no user is logged in, it redirects to the login page.
  def index
    if Current.user
      if Current.user.is_admin?
        redirect_to admin_index_path
      else
        redirect_to index_path
      end
    else
      redirect_to login_path
    end
  end

  # New home page action: Renders the new home page.
  def new; end
end
