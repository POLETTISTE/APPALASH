# frozen_string_literal: true

class RenameClientIdToGuestIdInTransactions < ActiveRecord::Migration[8.0]
  def change
    rename_column :transactions, :client_id, :guest_id
  end
end
