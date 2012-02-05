class AddStateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :read_intro, :boolean
  end
end
