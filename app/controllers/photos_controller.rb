class PhotosController < ApplicationController

  before_filter :check_logged_in
  before_filter :get_photo, :only => [:show, :download, :destroy]
  before_filter :check_owner, :only => [:destroy, :download]
  private


  def get_photo
    @photo = Photo.find_by_id(params[:id])
    unless @photo
      flash[:error] = "Sorry, We couldn't find the requested photo"
      redirect_to photos_path
    end    
  end

  def check_owner
    if @photo.user!=current_user
      flash[:error] = "Sorry, You are not a valid user"
      redirect_to photos_path
    end
  end
  
  public

  def index
    @photos = Photo.where(:user_id => current_user.id)
  end

  def show
  end

  def download
    send_file(@photo.photo.path, :filename => @photo.photo_file_name, :disposition => "attachment")
  end

  def new
    @photo = Photo.new
  end  

  def create
    @photo = Photo.new(params[:photo])

    if !["image/jpg", "image/jpeg", "image/JPG", "image/JPEG", "image/png", "image/PNG"].include?(params[:photo][:photo].content_type)
      @photo.errors.add(:base, "Please upload jpge/png files only")
      render :action => :new and return
    end

    @photo.user = current_user
    if @photo.save
      flash[:notice] = "Photo has been saved successfully!"
      redirect_to photo_path(@photo)
    else
      render :action => :new
    end  
  end

  def destroy
    @photo.destroy
    flash[:notice] = "Photo has been removed successfully"
    redirect_to photos_path
  end

end
