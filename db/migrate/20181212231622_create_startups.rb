class CreateStartups < ActiveRecord::Migration[5.1]
  def change
    create_table :startups do |t|
      t.string :name

      t.timestamps
    end
  end
end
