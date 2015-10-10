class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :user_t, presence: true

end
