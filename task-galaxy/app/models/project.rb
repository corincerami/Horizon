class Project < ActiveRecord::Base
  has_many :project_users
  has_many :user, through: :project_users

  has_many :project_tasks
  has_many :tasks, through: :project_tasks
end
