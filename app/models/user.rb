class User < ApplicationRecord
  has_secure_password

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[[:^alnum:]])/x

  belongs_to :organization

  validates :name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 3 }
  validates :password_confirmation, presence: true, if: -> { password.present? }

  scope :get_users, ->() {
          where(organization_id: Current.user.organization_id, is_admin: false)
        }

  scope :get_organization_name, ->(organization_id) {
          joins(:organization).where("organizations.id = ?", Current.user.organization_id).pluck("organizations.name")
        }

  def self.invite_user(email)
    random_user_password = generate_random_password
    user = User.new(name: generate_name,
                    email: email,
                    organization_id: Current.user.organization_id,
                    password: random_user_password,
                    password_confirmation: random_user_password)
    if user.valid?
      user.save
    else
      user.errors.add(:email, "User already exists.")
    end
    user
  end

  private

  def self.generate_random_password
    SecureRandom.urlsafe_base64(12)
  end

  def self.generate_name
    organization_name = Organization.find(Current.user.organization_id).name
    last_user_id = User.last.id
    "#{organization_name}_User_#{last_user_id + 1}"
  end
end
