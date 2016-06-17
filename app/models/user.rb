class User < ActiveRecord::Base
  validates :phone_number, presence: true, uniqueness: true

  before_save :default_values

  has_many :clues

  def default_values
    self.points ||= 0
  end
end
