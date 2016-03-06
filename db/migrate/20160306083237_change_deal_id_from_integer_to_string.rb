class ChangeDealIdFromIntegerToString < ActiveRecord::Migration
  def change
  	change_column :logs, :deal_id, :string
  end
end
