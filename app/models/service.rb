class Service < ActiveRecord::Base
  ActiveRecord::Base.include_root_in_json = false
  belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :provider, :class_name => 'User', :foreign_key => 'provider_id'
  
  has_one :service_status

  def as_json(options={})
    @u = :user
    @l = Location.find_by(user: @u)
    super(
      :only => [:id, :s_date, :s_status, :latitude, :longitude, :s_t, :message],    
      :include => {
        :user => {
          :only => [:name],
          :include => {
            :location => {
              :only => [:latitude, :longitude]
            }
          }
        },
        :provider => {
          :only => [:name],
          :include => {
            :location => {
              :only => [:latitude, :longitude]
            }
          }
        }  
      }
    )
  end
end
