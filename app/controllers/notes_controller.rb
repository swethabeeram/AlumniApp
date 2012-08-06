class NotesController < ApplicationController

  before_filter :check_logged_in
  before_filter :get_file, :only => [:show, :download, :destroy]
  before_filter :check_owner, :only => [:destroy, :download]

  private

  def get_file
    @note = Note.find_by_id(params[:id])
    unless @note
      flash[:error] = "Sorry, We couldn't find the requested note"
      redirect_to notes_path
    end    
  end

  def check_owner
    if @note.user!=current_user
      flash[:error] = "Sorry, You are not a valid user"
      redirect_to notes_path
    end
  end
  
  public

  def index
    @notes = Note.all
  end

  def show
    @commentable = @note
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def download
    send_file(@note.file.path, :filename => @note.file_file_name, :disposition => "note")
  end

  def new
    @note = Note.new
  end  

  def create
    @note = Note.new(params[:note])
    @note.user = current_user
    if @note.save
      flash[:notice] = "Note has been saved successfully!"
      redirect_to notes_path
    else
      render :action => :new
    end  
  end

  def destroy
    @note.destroy
    flash[:notice] = "Note has been removed successfully"
    redirect_to notes_path
  end
end
