class CreateRounds < ActiveRecord::Migration[5.1]
  def change
    create_table :rounds do |t|
      t.references :startup, foreign_key: true
      t.integer :amount_to_raise
      t.integer :amount_open_to_wallet

      t.timestamps
    end
  end
end
