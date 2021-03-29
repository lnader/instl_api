class Efile < ApplicationRecord
  has_many :awards, dependent: :destroy
end
