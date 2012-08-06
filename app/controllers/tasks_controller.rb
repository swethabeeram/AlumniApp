class TasksController < ApplicationController

  before_filter :check_logged_in, :only => [:create, :new, :edit, :update, :destroy]


  before_filter :get_event

  private

  def get_event
    @event = Event.find_by_id(params[:event_id])
    if @event.nil?
      flash[:notice] = "Sorry, no event was found!"
      redirect_to events_path
    end
  end

  public

  def create
    @task = @event.tasks.build(params[:task])
    @task.user = current_user
    if @task.save
      flash[:notice] = "Task Successfully Saved!"
      redirect_to event_path(@event)
    else
      flash[:error] = "Errors in savinf the comment, Please try again"
      redirect_to event_path(@event)
    end
  end

  def destroy
    @task = @event.tasks.find_by_id(params[:id])
    @task.destroy
    flash[:notice] = "Task has been successfully deleted"
    redirect_to task_path(@task)
  end

end
