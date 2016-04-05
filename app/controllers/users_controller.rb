class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @wiki = Wiki.find(params[:id])
    @wikis = @user.wikis
  end

  def downgrade
    if current_user.role == 'premium'
      current_user.update_attributes!(role: 'standard')
      flash[:notice] = "Membership Downgraded!"
      redirect_to user_path(current_user)
    else
      flash[:error] = "There was an error downgrading your membership. Please try again."
      redirect_to user_path(current_user)
    end
  end
end
