class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :type, presence: true

end
