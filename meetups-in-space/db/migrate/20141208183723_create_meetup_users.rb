class CreateMeetupUsers < ActiveRecord::Migration
  def change
    create_table :meetup_users do |t|
      t.integer :meetup_id, null: false
      t.integer :user_id, null: false
    end
  end
end
