class Clue < ActiveRecord::Base
  validates :question, :answer, :category, presence: true

  belongs_to :user
end
