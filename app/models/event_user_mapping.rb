class EventUserMapping < ActiveRecord::Base
  attr_accessible :event_id, :user_id

  belongs_to :user
  belongs_to :event

  validates :event_id, :presence => :true
  validates :user_id, :presence => :true

  validates_uniqueness_of :event_id, :scope => [:user_id]
    
  #or
  #validates_uniqueness_of :user_id, :scope => [:event_id]

end
