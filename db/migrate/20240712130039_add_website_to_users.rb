# frozen_string_literal: true

class AddWebsiteToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :website, :string
    add_index :users, :website, unique: true
  end
end
