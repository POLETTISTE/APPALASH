# frozen_string_literal: true

class AddUuidToActiveStorageTables < ActiveRecord::Migration[8.0]
  def up
    # In the `up` method, we define how to apply the migration.
    change_column :active_storage_attachments, :record_id, :string, limit: 36
  end

  def down
    # In the `down` method, we define how to reverse the migration.
    change_column :active_storage_attachments, :record_id, :string, limit: nil # or the original limit, if any
  end
end
