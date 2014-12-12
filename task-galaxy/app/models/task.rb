class Task < ActiveRecord::Base
  belongs_to :projects
  belongs_to :users

  validates_presence_of :name, :project_id, :user_id
end
