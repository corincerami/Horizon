class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :restaurant_id, null: false
      t.integer :rating,        null: false
      t.string  :body
      t.timestamps
    end
  end
end
