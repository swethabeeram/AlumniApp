class EventsController < ApplicationController

  before_filter :check_logged_in, :only => [:create, :new, :edit, :update, :destroy]

  before_filter :get_event_object, :only => [:rsvp, :remove_rsvp, :show, :edit, :update, :destroy]

  before_filter :check_owner, :only => [:edit, :update, :destroy]

  private

  def get_event_object
    if params[:commit] == "Cancel"
      redirect_to events_path and return
    end

    @event = Event.find_by_id(params[:id])
    if @event.nil?
      flash[:error] = "Sorry, No event was found!"
      redirect_to events_path
    end    
  end

  def check_owner
    if @event.users!=current_user
      flash[:error] = "Sorry, You are not a valid user"
      redirect_to events_path
    end
  end
  
  public

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
    @users = User.find(:all)
  end

  def create
    @event = Event.new(params[:event])
    @event.user = current_user
    if @event.save
      flash[:notice] = "Event has been successfully created"
      redirect_to events_path
    else
      render :action => :new
    end
  end

  def show
    @commentable = @event
    @comments = @commentable.comments
    @comment = Comment.new
    @task = Task.new
  end

  def edit
  end

  def update
    if @event.update_attributes(params[:event])
      flash[:notice] = "Event has been successfully updated."
      redirect_to event_path(@event)
    else
      flash[:error] = "Unable to save the event"
      render :action => :edit
    end
  end

  def rsvp
    if @event.users.include?(current_user)
      flash[:error] = "RSVP has already been accepted"
    else
      flash[:notice] = "RSVP has been accepted"
      @event.users << current_user
    end
    redirect_to event_path(@event)
  end

  def remove_rsvp
    if @event.users.include?(current_user)
      @event.users.delete(current_user)
      flash[:notice] = "RSVP has been successfully removed"
    else
      flash[:error] = "Sorry, you have not RSVP for the event"
    end
    redirect_to event_path(@event)
  end


end
