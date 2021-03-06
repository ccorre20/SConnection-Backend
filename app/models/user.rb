class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :user_t, presence: true
  
  has_many :services_as_user, :class_name => 'Service', :foreign_key => 'user_id'
  has_many :services_as_provider, :class_name => 'Service', :foreign_key => 'provider_id'

  has_one :location

  has_one :provider_profile_as_provider, :class_name => 'ProviderProfile', :foreign_key => 'provider_id'

  def as_json(options={})
    @u = :user
    @l = Location.find_by(user: @u)
    super(
      :include => {
        :location => {
          :only => [:latitude, :longitude]
        },
        :provider_profile_as_provider => {
          :only => [:availability, :description]
        }
      }
    )
  end

end
