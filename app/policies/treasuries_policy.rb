class TreasuriesPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  
  def show?
    return true
  end

  def advise?
    return true
  end

  def comments?
    return true
  end

  def transactions?
    return true
  end
end
  