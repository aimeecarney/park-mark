class User < ActiveRecord::Base
  has_many :spots
  has_secure_password
end
