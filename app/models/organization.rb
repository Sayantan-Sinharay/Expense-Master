# frozen_string_literal: true

# Represents the organization model in the application.
class Organization < ApplicationRecord
  has_many :users, dependent: :destroy, inverse_of: :organization
  has_many :categories, dependent: :destroy, inverse_of: :organization

  after_create :create_tenant
  after_destroy :delete_tenant

  validates :name, presence: { message: "Organization name can't be blank" },
                   format: { with: /\A[a-zA-Z\s'\-,&]+\z/, message: 'Organization name is invalid' },
                   uniqueness: { message: 'Organization name must be unique' },
                   length: { in: 2..50, message: 'Organization name must be between 2 and 50 characters' }
  validates :email, presence: { message: 'Organization must have an email' },
                    format: { with: EMAIL_REGEX, message: 'Organization email is invalid' },
                    uniqueness: { message: 'Organization email must be unique' }
  validates :subdomain, presence: { message: 'Please enter a subdomain ' },
                        format: { with: SUBDOMAIN_REGEX, message: 'Subdomain is invalid' },
                        uniqueness: { message: 'Subdomain is already taken.' }

  private

  def create_tenant
    Apartment::Tenant.create(subdomain)
  end

  def delete_tenant
    Apartment::Tenant.drop(subdomain)
  end
end
