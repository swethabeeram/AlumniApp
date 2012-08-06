class User < ActiveRecord::Base
  attr_accessible :course_id, :email, :hashed_password, :name, :year_of_passing, :password, :password_confirmation

  attr_accessor :password, :password_confirmation

  belongs_to :course
  has_many :messages, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :photos, :dependent => :destroy
  has_many :notes, :dependent => :destroy
  has_many :tasks, :dependent => :destroy


  has_many :event_user_mappings, :dependent => :destroy
  has_many :events, :through => :event_user_mappings

  validates :name, :presence => true
  validates :email, :uniqueness => true, :presence => true, :format => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i


  validates :password, :presence => true, :confirmation => true
  validates :password_confirmation, :presence => true

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user
      if Digest::SHA1.hexdigest(password) == user.hashed_password #Password provided matches our record
        return user
      else #i.e password provided is in correct
        return false
      end
    else #user was not found with the provided email, hence we will return false
      return false
    end  
  end

  before_save do
    unless password.blank?
      set_hashed_password
    end
  end

  private

  def set_hashed_password
      self.hashed_password = Digest::SHA1.hexdigest(password)
  end


end
