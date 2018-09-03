class CollaboratorsController < ApplicationController
  def new
    @collaborator=Collaborator.new
    @wiki=Wiki.find(params[:wiki_id])
  end
  
  def create
    # adding 1 new collab
    @collaborator = Collaborator.new
    @collaborator.wiki_id = Integer(params[:wiki_id])
    @wiki=Wiki.find(params[:wiki_id]) # @wiki needed in scope by render :new
    
    if params[:new_cids].length>0
      @collaborator.user_id = Integer(params[:new_cids])
    else # preempt "must exist" error with "can't be blank"
      @collaborator.errors.add(:user, "can't be blank.")
      flash.now[:alert] =
        "There was an error saving the post. Please try again."
      render :new
      return
      # Why not add validate presence in the model definition to trigger
      # "can't be blank"? Belongs_to already checks for presence and triggers a
      # "must exist" error. Thus, adding validates presence is superfluous and
      # results in both "must exist" and "can't be blank". Furthermore,  
      # "must exist" implies a test of a candidate value. Thus, this block is
      # here so that a blank submission results in only "can't be blank", a more
      # clear message to the user. 
    end
    
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
