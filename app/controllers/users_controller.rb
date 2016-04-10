class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    # @wiki = Wiki.find(params[:id])
    @wikis = @user.wikis

    if user_signed_in?
      @amount = 15_00
      @stripe_btn_data = {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        description: "Premium Membership - #{current_user.email}",
        amount: @amount
      }
    else
      redirect_to root_path
      flash[:notice] = "You must be signed in to do that."
    end
  end

  def downgrade
    if current_user.role == 'premium'
      current_user.update_attributes!(role: 'standard')
      current_user.make_wikis_public
      flash[:notice] = "Membership Downgraded!"
      redirect_to user_path(current_user)
    else
      flash[:error] = "There was an error downgrading your membership. Please try again."
      redirect_to user_path(current_user)
    end
  end
end
