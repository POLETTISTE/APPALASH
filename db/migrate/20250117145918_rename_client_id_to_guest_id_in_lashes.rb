# frozen_string_literal: true

class RenameClientIdToGuestIdInLashes < ActiveRecord::Migration[8.0]
  def change
    rename_column :lashes, :client_id, :guest_id
  end
end
