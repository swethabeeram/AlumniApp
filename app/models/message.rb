class Message < ActiveRecord::Base
  attr_accessible :body, :title, :user_id

  belongs_to :user
  has_many :comments, :as => :commentable

  validates :title, :presence => true
  validates :body, :presence => true

end
