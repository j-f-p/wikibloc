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
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = ("There was an error saving the wiki." +
        "Please try again.")
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = ("There was an error saving the wiki." +
        "Please try again.")
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
end
