class CommentsController < ApplicationController

  before_filter :check_logged_in, :only => [:create, :new, :edit, :update, :destroy]

  before_filter :load_commentable

  private

  def load_commentable
    resource, id = request.path.split('/')[1,2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  public

  def create
    @comment = @commentable.comments.new(params[:comment])
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Successfully created comment."
      redirect_to @commentable
    else
      render :action => 'new'
    end
  end
  
 
end
