class Comment < ActiveRecord::Base
  attr_accessible :comment, :commentable_id, :commentable_type

  belongs_to :user
  belongs_to :commentable, :polymorphic => true

  validates :comment, :presence => true

end
