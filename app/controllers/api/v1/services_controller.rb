class Api::V1::ServicesController < ApplicationController

  def index
    if params[:name]
      if (@u = User.find_by name: params[:name]) != nil
        if(@u.user_t == 'user')
          render json: @u.services_as_user
        else
          render json: @u.services_as_provider
        end
      end
    end
  end


  def create
    
  end

end