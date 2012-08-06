class MessagesController < ApplicationController

  before_filter :check_logged_in, :only => [:create, :new, :edit, :update, :destroy]

  before_filter :get_message_object, :only => [:show, :edit, :update, :destroy]

  before_filter :check_owner, :only => [:edit, :update, :destroy]

  private

  def get_message_object
    if params[:commit] == "Cancel"
      redirect_to messages_path and return
    end

    @message = Message.find_by_id(params[:id])
    if @message.nil?
      flash[:error] = "Sorry, No message was found!"
      redirect_to messages_path
    end    
  end

  def check_owner
    if @message.user!=current_user
      flash[:error] = "Sorry, You are not a valid user"
      redirect_to messages_path
    end
  end
  
  public

  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    @message.user = current_user
    if @message.save
      flash[:notice] = "Message has been successfully created"
      redirect_to messages_path
    else
      render :action => :new
    end
  end

  def show
    @commentable = @message
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @message.update_attributes(params[:message])
      flash[:notice] = "Message has been successfully updated."
      redirect_to message_path(@message)
    else
      render :action => :edit
    end
  end

  def destroy
    @message.destroy
    flash[:notice] = "Message has been deleted."
    redirect_to messages_path
  end
end
