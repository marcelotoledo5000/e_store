class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.datetime :date
      t.references :customer, foreign_key: true
      t.integer :status, default: 0
      t.decimal :freight

      t.timestamps
    end
  end
end
