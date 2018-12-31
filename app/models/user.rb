class User < ApplicationRecord
  has_many :trees, through: :collection
  has_secure_password
  validates :username, uniqueness: { case_sensitive: false }
end
