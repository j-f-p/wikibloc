class CollaboratorsController < ApplicationController
  def new
    @collaborator=Collaborator.new
    @wiki=Wiki.find(params[:collab_wiki_id])
  end
  
  def create
    # adding 1 new collab
    @collaborator = Collaborator.new
    @collaborator.wiki_id = Integer(params[:new_cids_wid])
    @collaborator.user_id = Integer(params[:new_cids])
  end
end
