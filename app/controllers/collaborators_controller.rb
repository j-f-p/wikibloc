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
    
    @wiki=Wiki.find(params[:wiki_id]) # @wiki needed in scope by render :new
    if @collaborator.user_id!=current_user.id && @collaborator.save
      flash[:notice] = "Collaborator was saved."
      redirect_to @wiki
    else
      flash.now[:alert] =
        "There was an error saving the post. Please try again."
      render :new
    end
  end
end
