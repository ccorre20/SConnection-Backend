class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :user_t, presence: true
  
  has_many :services, :class_name => 'Service', :foreign_key => 'user_id'
  has_many :services, :class_name => 'Service', :foreign_key => 'provider_id'
end
