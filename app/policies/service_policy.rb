# frozen_string_literal: true

class ServicePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.present? && user.admin? ? scope.all : scope.where(user: user)
    end
  end

  def index?
    true
  end

  def show?
    user.present? && (record.user == user || user.admin?)
  end

  def create?
    user.present? && !user.admin?
  end

  def new?
    create?
  end

  def update?
    user.present? && (record.user == user || user.admin?)
  end

  def edit?
    update?
  end

  def destroy?
    user.present? && (record.user == user || user.admin?)
  end
end
