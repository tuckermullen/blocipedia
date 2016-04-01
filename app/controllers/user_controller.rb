class UserController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @wiki = Wiki.new
    @wikis = @user.wikis
  end

  def downgrade
    current_user.update_attributes!(role: 'standard')

    if current_user.role == 'standard'
      flash[:notice] = "Membership Downgraded!"
    else
      flash[:error] = "There was an error downgrading your membership. Please try again."
    end
  end
end
