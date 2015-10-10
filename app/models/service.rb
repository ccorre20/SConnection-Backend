class Service < ActiveRecord::Base
  belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :provider, :class_name => 'User', :foreign_key => 'provider_id'
end
