class CollaboratorsController < ApplicationController
  def new
    @collaborator=Collaborator.new
    @wiki=Wiki.find(params[:collab_wiki_id])
  end
end
