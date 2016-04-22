class CollaboratorsController < ApplicationController
  before_action :authenticate_user!

  def new
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new
    @collaborator.wiki = @wiki
    @collaborator.user = current_user

    if @collaborator.save
      flash[:notice] = "You've added yourself as a collaborator."
    else
      flash[:alert] = "There was an error adding yourself as a collaborator, please try again."
    end
    redirect_to @wiki
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find_by(user_id: current_user.id, wiki_id: @wiki.id)

    if @collaborator.destroy
      flash[:notice] = "You've removed yourself as a collaborator for this Wiki."
    else
      flash[:alert] = "There was an error removing yourself as a collaborator, please try again."
    end
    redirect_to @wiki
  end
end
