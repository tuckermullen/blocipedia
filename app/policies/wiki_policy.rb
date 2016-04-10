class WikiPolicy < ApplicationPolicy

  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def new?
    create?
  end

  def create?
    user.present?
  end

  def index?
    user.present?
  end

  def edit?
    update?
  end

  def show?
    user.present?
  end

  def update?
    user.present?
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      # if user.present?
      #   scope.all
      # else
      #   scope.where(private: false)
      # end
      scope.all
    end
  end
end
