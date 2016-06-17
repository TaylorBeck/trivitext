class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :phone_number, null: false
      t.integer :points, null: false

      t.timestamps(null: false)
    end
  end
end
