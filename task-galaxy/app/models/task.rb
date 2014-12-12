class Task < ActiveRecord::Base
  belongs_to :projects
  belongs_to :users

  validates :name, presence: true, :project_id, presence: true, :user_id, presence: true
end
