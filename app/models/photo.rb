class Photo < ActiveRecord::Base
  attr_accessible :event_id, :user_id, :photo

  belongs_to :user
  belongs_to :event

  has_attached_file :photo, :style => {:thumb => "50x50>", :medium => "100x100>"},
:path => ":rails_root/public/system/:attachment/:id/:style/:filename", 
:url => "/system/:attachment/:id/:style/:filename"


end
