class ExpenditurePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def transactions?
    true
  end

  def advice?
    true
  end

  def comments?
    true
  end
end
