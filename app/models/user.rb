class User < ApplicationRecord
  validates_presence_of :username
  validates_presence_of :password_confirmation, on: :create
  validates :nickname, length: { maximum: 100 }

  has_secure_password
end
