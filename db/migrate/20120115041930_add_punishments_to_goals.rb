class AddPunishmentsToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :payment, :integer
    add_column :goals, :emails, :string
    add_column :goals, :other, :string
  end
end
