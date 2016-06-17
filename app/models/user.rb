class User < ActiveRecord::Base
  validates :phone_number, presence: true, uniqueness: true
  validates :points, presence: true

  has_many :clues
end
