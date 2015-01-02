class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string  :color,             null: false
      t.integer :year,              null: false
      t.string  :manufacturer_id,   null: false
      t.integer :mileage,           null: false
      t.text    :description
    end
  end
end
