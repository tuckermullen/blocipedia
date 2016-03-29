class UserController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @wiki = Wiki.new
    @wikis = @user.wikis
  end
end
