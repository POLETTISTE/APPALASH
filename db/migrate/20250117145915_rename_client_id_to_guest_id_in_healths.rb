class RenameClientIdToGuestIdInHealths < ActiveRecord::Migration[8.0]
  def change
    rename_column :healths, :client_id, :guest_id

  end
end
