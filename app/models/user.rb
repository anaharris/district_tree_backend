class User < ApplicationRecord
  has_many :trees, through: :collection
  has_secure_password
end
