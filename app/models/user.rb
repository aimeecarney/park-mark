class User < ActiveRecord::Base
  has_many :spots
  has_secure_password
  validates :email, :username, uniqueness: true
  validates :email, :username, presence: true
end
