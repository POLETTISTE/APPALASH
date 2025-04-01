# frozen_string_literal: true

class RenameClientsToGuests < ActiveRecord::Migration[8.0]
  def change
    rename_table :clients, :guests
  end
end
