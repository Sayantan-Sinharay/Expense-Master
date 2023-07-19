class User < ApplicationRecord
  has_secure_password

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[[:^alnum:]])/x

  belongs_to :organization
  has_many :budgets
  has_many :expenses
  has_many :wallets
  has_many :notifications, dependent: :destroy

  validates :name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 3 }
  validates :password_confirmation, presence: true, if: -> { password.present? }

  scope :get_non_admin_users, ->(organization_id) {
          where(organization_id: organization_id, is_admin?: false)
        }

  scope :get_admin_users, ->(organization_id) {
          where(organization_id: organization_id, is_admin?: true)
        }

  def self.invite_user(admin_user, email)
    password = SecureRandom.urlsafe_base64(12)
    user = User.new(name: generate_name(admin_user.organization.name),
                    email: email,
                    organization_id: admin_user[:organization_id],
                    password: password,
                    password_confirmation: password)
    user if user.valid?
  end

  private

  def self.generate_name(organization_name)
    organization_name = organization_name
    last_user_id = User.last.id
    "#{organization_name}" + "#User" + "#{last_user_id + 1}"
  end
end
