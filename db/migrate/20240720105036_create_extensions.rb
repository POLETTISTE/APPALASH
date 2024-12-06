# frozen_string_literal: true

class CreateExtensions < ActiveRecord::Migration[7.1]
  def change
    create_table :extensions, id: :uuid do |t|
      t.text :brand
      t.text :curvature
      t.integer :thickness
      t.text :glue
      # t.references :client, null: false, foreign_key: true
      t.uuid :client_id

      t.timestamps
    end
  end
end
