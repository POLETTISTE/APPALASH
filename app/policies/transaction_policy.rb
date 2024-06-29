# frozen_string_literal: true

class TransactionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # user.admin? ? scope.all : scope.where(user: user)
      # scope.where(user: user)

      # if user.admin?
      #   scope.all # Admin can see all clients
      # else
      #   scope.where(user_id: user.id) # Regular users can only see their own clients
      # end
    end
  end
end
