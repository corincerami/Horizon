class Question < ActiveRecord::Base
  has_many :answers

  accepts_nested_attributes_for :answers

  validates :title, presence: true, length: { minimum: 40, message: "is too short. Must be 40 characters" }
  validates :description, presence: true, length: { minimum: 150, message: "is too short. Must be 150 characters" }
end
