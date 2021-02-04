class LinePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
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
    record.user == user
    # - record: the restaurant passed to the `authorize` method in controller
    # - user:   the `current_user` signed in with Devise.
    end
  
    def edit?
      update?
    end
  
    def destroy?
      record.user == user
    end
  end
