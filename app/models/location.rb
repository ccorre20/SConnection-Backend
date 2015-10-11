class Location < ActiveRecord::Base
  validates :user_id, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true

  belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'
end
