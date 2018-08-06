class CollaboratorsController < ApplicationController
  def new
    @collaborator=Collaborator.new
    @wiki=Wiki.find(params[:wiki_id])
  end
  
  def create
    # adding 1 new collab
    @collaborator = Collaborator.new
    @collaborator.wiki_id = Integer(params[:wiki_id])
    @collaborator.user_id = Integer(params[:new_cids])
    
    # if @collaborator.save
    #   flash[:notice] = "Collaborator was saved."
    #   redirect_to Wiki.find(params[:new_cids_wid])
    # else
    #   flash.now[:alert] =
    #     "There was an error saving the post. Please try again."
    #   render :new
    # end
  end
end
