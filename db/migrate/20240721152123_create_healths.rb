# frozen_string_literal: true

class CreateHealths < ActiveRecord::Migration[7.1]
  def change
    create_table :healths, id: :uuid do |t|
      t.boolean :diabetes
      t.boolean :pregnancy
      t.boolean :dry_eyes
      t.boolean :teary_eyes
      t.boolean :allergy
      t.boolean :contact_lenses
      t.boolean :surgery
      t.boolean :chemotherapy
      t.boolean :eyes_allergy
      t.boolean :itch
      t.boolean :first_application
      t.boolean :lie_down
      t.text :notes
      # t.references :client, null: false, foreign_key: true
      t.uuid :client_id

      t.timestamps
    end
  end
end
