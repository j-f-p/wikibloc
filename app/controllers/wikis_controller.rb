class WikisController < ApplicationController
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)
    @wiki.private = false if @wiki.private==nil # to show empty checkbox

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = ("There was an error saving the wiki." +
        "Please try again.")
      @wiki.private = nil # so that wiki new form can show private checkbox
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    db_wiki_private = @wiki.private # the value in the database
    
    @wiki.assign_attributes(wiki_params)
    @wiki.private = false if @wiki.private==nil # to appease validator
    
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = ("There was an error saving the wiki." +
        "Please try again.")
        
      @wiki.private=true if db_wiki_private==true
      # when a private wiki is desired to be made public, require uncheck of
      # private checkbox for each submission attempt following an error
      
      # @wiki.private=nil if db_wiki_private==false
      # assigned nil by form when checkbox not rendered
      #  either this logic or a hidden field, though viewable in page source
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end
  
  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    flash[:alert] = t "#{policy_name}.#{exception.query}", scope: "pundit",
      default: :default
    redirect_to(request.referrer || wikis_path)
  end
  
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
