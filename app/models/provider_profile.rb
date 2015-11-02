class ProviderProfile < ActiveRecord::Base
  belongs_to :provider, :class_name => 'User', :foreign_key => 'provider_id'
end
