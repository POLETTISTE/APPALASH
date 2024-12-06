# frozen_string_literal: true

class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients, id: :uuid do |t|
      t.string :name
      t.string :firstname
      t.string :email
      t.string :phone
      t.string :address
      t.string :zip_code
      t.string :city
      t.string :country
      t.date :birthdate
      t.text :how_do_you_know_us
      t.text :notes
      t.timestamps
    end
  end
end
