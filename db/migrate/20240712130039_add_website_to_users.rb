# frozen_string_literal: true

class AddWebsiteToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :website, :string, null: false
    add_column :users, :name, :string, null: true
    add_column :users, :firstname, :string, null: true

  end
end
