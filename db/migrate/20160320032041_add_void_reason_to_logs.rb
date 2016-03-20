class AddVoidReasonToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :void_reason, :string
  end
end
