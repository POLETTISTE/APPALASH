# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all # Default to allowing access to all users
    end
  end

  def index_personal_information?
    true
  end
  
  def show_website?
    true
  end

  def edit_website?
    user && (user.admin? || user == record) # Allow owner or admin to edit
  end

  def update_website?
    edit_website? # Defer to edit? for update permissions
  end
end
