class Comment < ActiveRecord::Base
  attr_accessible :email, :user_name, :ip, :comment

  validates_against_stopforumspam :username => :user_name, :on => :create
end
