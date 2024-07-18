# frozen_string_literal: true

class AddWebsiteToUsers < ActiveRecord::Migration[7.1]
  def up
    add_column :users, :website, :string
    add_index :users, :website, unique: true
  end

  def down
    remove_index :users, :website if index_exists?(:users, :website, unique: true)
    return unless column_exists?(:users, :website)

    remove_column :users, :website
  end
end
