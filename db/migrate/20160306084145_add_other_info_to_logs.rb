class AddOtherInfoToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :salesperson, :string
    add_column :logs, :voucher_no, :string
  end
end
