class Meetup < ActiveRecord::Base
  has_many :meetup_users
  has_many :users, through: :meetup_users
  has_many :comments

  validates_presence_of :name, message: "is required."
  validates_presence_of :location, message: "is required."
  validates_presence_of :description, message: "is required."
end
