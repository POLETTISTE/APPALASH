# frozen_string_literal: true

class RenameClientIdToGuestIdInExtensions < ActiveRecord::Migration[8.0]
  def change
    rename_column :extensions, :client_id, :guest_id
  end
end
