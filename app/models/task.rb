class Task < ActiveRecord::Base
  attr_accessible :description, :event_id, :title, :user_id

  belongs_to :event
  belongs_to :user
end
