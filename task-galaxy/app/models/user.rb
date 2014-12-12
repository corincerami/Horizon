class User < ActiveRecord::Base
  has_many :project_users
  has_many :projects, through: :project_users

  has_many :user_tasks
  has_many :tasks, through: :user_tasks
end
