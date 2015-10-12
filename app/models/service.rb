class Service < ActiveRecord::Base
  ActiveRecord::Base.include_root_in_json = false
  belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :provider, :class_name => 'User', :foreign_key => 'provider_id'

  def as_json(options={})
    super(:only => [:id, :s_date, :s_status, :latitude, :longitude, :s_t, :message],
          :include => {
            :user => {:only => [:name]},
            :provider => {:only => [:name]}
          }
    )
  end
end
