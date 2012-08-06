class UsersController < ApplicationController

  before_filter :check_not_logged_in, :only => [:login, :new, :signup]

  def login
    if request.post?
      @user = User.authenticate(params[:user][:email],params[:user][:password])
      if @user.is_a?(User)
        flash[:notice] = "User successfully authenticated!"
        session[:current_user] = @user
        redirect_to messages_path
      else
        flash[:error] = "Incorrect email or password, please try again."
        redirect_to login_users_path        
      end
    else #i.e get request
      #for testing the get request
      #flash[:notice] = "This is Get request"
    end
  end

  def new
    @user = User.new
  end

  def signup
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Congrats You have successfully signed up! Please login to continue."
      redirect_to login_users_path
    else
      flash[:error] = "Sorry, you could not sign uo because of following errors"
      render :action => :new
    end
  end

  def logout
    session[:current_user] = nil
    flash[:notice] = "You'he been successfully logged out"
    redirect_to users_path
  end

  def index
    @users = User.all
  end

end
