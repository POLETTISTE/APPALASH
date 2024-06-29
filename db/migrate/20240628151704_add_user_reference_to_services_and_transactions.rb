# frozen_string_literal: true

class AddUserReferenceToServicesAndTransactions < ActiveRecord::Migration[7.1]
  def change
    add_reference :services, :user, null: false, foreign_key: true
    add_reference :transactions, :user, null: false, foreign_key: true
  end
end
