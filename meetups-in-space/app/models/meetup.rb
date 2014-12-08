class Meetup < ActiveRecord::Base
  has_many :meetup_users
  has_many :users, through: :meetup_users

  validates_presence_of :name, message: "You must give your muppet a name"
  validates_presence_of :location, message: "You must give your muppet a location"
  validates_presence_of :description, message: "You must give your muppet a description"
end
