class CreatePunishments < ActiveRecord::Migration
  def change
    create_table :punishments do |t|
      t.references :goal
      t.string :payment
      t.string :emails
      t.string :other

      t.timestamps
    end
    add_index :punishments, :goal_id
  end
end
