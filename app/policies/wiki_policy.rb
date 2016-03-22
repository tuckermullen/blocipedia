class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def new
    user.present?
  end

  # def destroy?
    # user.admin?
    # user.created_at < 1.month.ago
  # end
end
