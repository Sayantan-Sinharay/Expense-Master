class User < ApplicationRecord
  has_secure_password

  # EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[[:^alnum:]])/x

  belongs_to :organization

  # validates :name, :email, presence: true
  # validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  # validates :password, presence: true, length: { minimum: 8 }, format: { with: PASSWORD_REGEX }
  # validates :password_confirmation, presence: true, if: -> { password.present? }

  scope :non_admins_by_organization, ->(organization_id) do
          where(organization_id: organization_id, is_admin: false)
        end
end
