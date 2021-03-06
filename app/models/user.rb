class User < ApplicationRecord
  has_secure_password

  validates :full_name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
