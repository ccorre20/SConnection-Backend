class Api::V1::ServiceStatusesController < ApplicationController

  def index
  end


  def create
    if params[:name] && params[:user]
      if (@u = User.find_by(name: params[:name])) != nil && (@o = User.find_by(name: params[:user])) != nil 
        if(@u.user_t == 'user')
          @s = Service.where(user: @u, provider: @p).take
          @.service_status
        else
        
        end    
      else
          
      end
    end
  
  end
end
