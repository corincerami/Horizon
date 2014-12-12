class User < ActiveRecord::Base
  has_many :project_users
  has_many :projects, through: :project_users

  has_many :tasks

  validates_presence_of :email, :password
end
