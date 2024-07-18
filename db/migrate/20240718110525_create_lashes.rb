# frozen_string_literal: true

class CreateLashes < ActiveRecord::Migration[7.1]
  def change
    create_table :lashes do |t|
      t.references :client, null: false, foreign_key: true
      t.string :desired_effect
      t.string :face_diagnostic
      t.string :asymmetry_diagnostic
      t.string :eyelid_morphology_diagnostic
      t.string :alignment_morphology_diagnostic
      t.string :proportion_morphology_diagnostic
      t.string :thickness_diagnostic
      t.integer :length_diagnostic
      t.boolean :curvature_diagnostic
      t.string :style
      t.text :notes
      t.text :mapping
      t.text :event
      t.boolean :texture
      t.string :density

      t.timestamps
    end
  end
end
