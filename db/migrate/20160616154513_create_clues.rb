class CreateClues < ActiveRecord::Migration
  def change
    create_table :clues do |t|
      t.string :question, null: false
      t.string :answer, null: false
      t.string :category, null: false
      t.integer :user_id, null: false

      t.timestamps(null: false)
    end
  end
end
