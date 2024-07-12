# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all # Default to allowing access to all users
    end
  end

  def show?
    true
  end

  def edit?
    user && (user.admin? || user == record) # Allow owner or admin to edit
  end

  def update?
    edit? # Defer to edit? for update permissions
  end
end
