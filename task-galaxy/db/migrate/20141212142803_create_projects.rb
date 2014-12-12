class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :description
      t.timestamps
    end
  end
end

# * A project is a collection of individual tasks.
# * A project must have a name.
# * A project can optionally have a description.
# * A project can have many users assigned to it.
