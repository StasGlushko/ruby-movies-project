class Film < ApplicationRecord
  GENRES = %w[action comedy drama horror rmance thriller sci-fi fantasy animation documentary musical western].freeze

  has_many :comments, as: :commentable, dependent: :destroy

  # validates
  validates :name, :year_of_creation, presence: true
  validates :name, uniqueness: true
  validates :description, length: { minimum: 10 }

end
