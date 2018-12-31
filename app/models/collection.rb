class Collection < ApplicationRecord
  belongs_to :tree
  belongs_to :user
end
