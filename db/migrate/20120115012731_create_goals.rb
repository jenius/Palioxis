class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.references :user
      t.string :name
      t.datetime :due

      t.timestamps
    end
    add_index :goals, :user_id
  end
end
