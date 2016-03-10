class AddViewerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :viewer, :boolean
  end
end
