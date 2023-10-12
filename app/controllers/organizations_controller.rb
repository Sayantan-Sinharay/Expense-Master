class OrganizationsController < ApplicationController
  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organizations_params)
    if @organization.save
    end
  end

  def organizations_params
    params.require(:organization).permit(:name, :email, :address, :subdomain)
  end
end
