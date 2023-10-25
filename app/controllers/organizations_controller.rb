# frozen_string_literal: true

class OrganizationsController < ApplicationController
  skip_before_action :require_login
  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organizations_params)
    if @organization.save
      redirect_to login_path
    else
      flash.now[:danger] = 'error'
      render :new
    end
  end

  def organizations_params
    params.require(:organization).permit(:name, :email, :address, :subdomain)
  end
end
