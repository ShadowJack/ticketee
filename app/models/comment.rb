class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket

  validates_presence_of :text

end
