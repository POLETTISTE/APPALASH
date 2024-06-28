class ClientPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # user.admin? ? scope.all : scope.where(user: user)
      scope.where(user: user)

      # if user.admin?
      #   scope.all # Admin can see all clients
      # else
      #   scope.where(user_id: user.id) # Regular users can only see their own clients
      # end
    end
  end

  def index?
    true
  end

  def show?
    record.user == user

  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    record.user == user

  end

  def edit?
    update?
  end

  def destroy?
    record.user == user

  end
end
