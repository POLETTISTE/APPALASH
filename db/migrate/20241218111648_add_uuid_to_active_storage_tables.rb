# frozen_string_literal: true

class AddUuidToActiveStorageTables < ActiveRecord::Migration[8.0]
  def change
    change_column :active_storage_attachments, :record_id, :string, limit: 36 # Assuming UUIDs are 36 chars
  end
end
