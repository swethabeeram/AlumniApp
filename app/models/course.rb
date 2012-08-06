class Course < ActiveRecord::Base
  attr_accessible :name

  has_many :users, :dependent => :destroy

end
