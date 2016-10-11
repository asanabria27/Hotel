class CreateAccountingAccounts < ActiveRecord::Migration
  def change
    create_table :accounting_accounts do |t|
      t.integer :grupo
      t.string :nombre
      t.boolean :imputable

      t.timestamps null: false
    end
  end
end