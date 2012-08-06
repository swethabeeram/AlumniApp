class Event < ActiveRecord::Base
  attr_accessible :description, :event_at, :title, :user_id, :event_at_date, :event_at_time

  attr_accessor :event_at_date, :event_at_time


  belongs_to :user

  has_many :comments, :as => :commentable
  has_many :photos, :dependent => :destroy
  has_many :tasks, :dependent => :destroy
  has_many :event_user_mappings, :dependent => :destroy
  has_many :users, :through => :event_user_mappings


  validates :title, :presence => true
  validates :description, :presence => true

  validates_format_of :event_at_time, :with => /\d{1,2}:\d{2}/


  after_initialize :get_datetimes
  before_validation :set_datetimes


 # add some callbacks
  after_initialize :get_datetimes # convert db format to accessors
  before_validation :set_datetimes # convert accessors back to db format

  def get_datetimes
    self.event_at ||= Time.now  # if the event_at time is not set, set it to now

    self.event_at_date ||= self.event_at.to_date.to_s(:db) # extract the date is yyyy-mm-dd format
    self.event_at_time ||= "#{'%02d' % self.event_at.hour}:#{'%02d' % self.event_at.min}" # extract the time
  end

  def set_datetimes
    self.event_at = "#{self.event_at_date} #{self.event_at_time}:00" # convert the two fields back to db
  end  


end
