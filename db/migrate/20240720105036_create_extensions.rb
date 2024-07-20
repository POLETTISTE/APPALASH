class CreateExtensions < ActiveRecord::Migration[7.1]
  def change
    create_table :extensions do |t|
      t.text :lash_extensions_brand
      t.text :lash_extensions_curvature
      t.integer :lash_extensions_thickness
      t.text :lash_extensions_glue
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
