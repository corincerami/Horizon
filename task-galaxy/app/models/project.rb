class Project < ActiveRecord::Base
  has_many :project_users
  has_many :user, through: :project_users

  has_many :tasks

  validates :name, presence: true
end
