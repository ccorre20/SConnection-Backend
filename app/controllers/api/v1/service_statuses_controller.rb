class Api::V1::ServiceStatusesController < ApplicationController

  def index
  end


  def create
    if params[:name]
      if params[:user]
        if (@p = User.find_by(name: params[:name])) != nil && @p.user_t == 'provider' && (@u = User.find_by(name: params[:user])) != nil && @u.user_t == 'user'
          
        else
          
        end
      elsif params[:provider]
      
      else
      
      end
    end
  
  end
end
