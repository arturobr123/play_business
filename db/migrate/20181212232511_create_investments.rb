class CreateInvestments < ActiveRecord::Migration[5.1]
  def change
    create_table :investments do |t|
      t.references :user, foreign_key: true
      t.references :round, foreign_key: true
      t.integer :amount
      t.integer :wallet_amount

      t.timestamps
    end
  end
end
