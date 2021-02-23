class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    return true
  end

  def show?
    return true
  end

  def create?
    return true
  end

  def new?
    create?
  end

  def update?
    return true
  end

  def edit?
    update?
  end

  def destroy?
    return true
  end
end
