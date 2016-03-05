class AddPayeeNameToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :payee_name, :string
  end
end
