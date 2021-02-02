class ExpenditurePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def expenditure?
    true
  end


end
