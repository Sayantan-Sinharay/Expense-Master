# frozen_string_literal: true

# HomesController handles home-related actions.
class HomesController < ApplicationController
  def index
    redirect_to determine_path
  end

  def new; end

  private

  def determine_path
    if Current.user
      Current.user.is_admin? ? admin_index_path : index_path
    else
      login_path
    end
  end
end
