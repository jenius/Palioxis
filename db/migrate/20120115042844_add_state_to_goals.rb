class AddStateToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :state, :string
  end
end
