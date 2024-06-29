# frozen_string_literal: true

class TransactionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.admin? ? scope.all : scope.where(user:)
    end
  end

  def index?
    true
  end

  def show?
    record.user == user || user.admin?
  end

  def create?
    !user.admin?
  end

  def new?
    create?
  end

  def update?
    record.user == user || user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    record.user == user || user.admin?
  end
end
