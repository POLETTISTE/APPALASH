# frozen_string_literal: true

class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services, id: :uuid do |t|
      t.string :name
      t.float :price

      t.timestamps
    end
  end
end
