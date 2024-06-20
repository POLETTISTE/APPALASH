# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.date :date
      t.references :client, null: false, foreign_key: true
      t.json :prestations, default: []
      t.integer :total_price

      t.timestamps
    end
  end
end
