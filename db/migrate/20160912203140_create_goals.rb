class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.text :details, null: false
      t.integer :user_id, null: false
      t.boolean :visibility, null: false
      t.boolean :completed, null: false

      t.timestamps null: false
    end

    add_index :goals, :user_id
  end
end
