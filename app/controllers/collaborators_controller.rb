class CollaboratorsController < ApplicationController
  before_action :authenticate_user!

  def new
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new(collaborator_params)
    @collaborator.wiki = @wiki

    if @collaborator.save
      flash[:notice] = "You've added yourself as a collaborator."
      redirect_to @wiki
    else
      flash[:alert] = "There was an error adding yourself as a collaborator, please try again."
    end
    redirect_to @wiki
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "You've removed yourself as a collaborator for this Wiki."
      redirect_to @wiki
    else
      flash[:alert] = "There was an error removing yourself as a collaborator, please try again."
      redirect_to @wiki
    end
    redirect_to @wiki
  end

  private

  def collaborator_params
    params.require(:collaborator).permit(:user_id, :wiki_id)
  end
end
