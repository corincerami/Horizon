class User < ActiveRecord::Base
  has_many :project_users
  has_many :projects, through: :project_users

  has_many :tasks

  validates :email, presence: true, :password, presence: true
end
