class Api::V1::ServicesController < ApplicationController

  def index
    if params[:name]
      if (@u = User.find_by name: params[:name]) != nil
        if(@u.user_t == 'user')
          if params[:only] && params[:only] == 'sent'
            render json: @u.services_as_user.where(s_status: 'sent')
          elsif params[:only] && params[:only] == 'done' 
            render json: @u.services_as_user.where(s_status: 'done')
          else
            render json: @u.services_as_user
          end
        else
          if params[:only] && params[:only] == 'sent'
            render json: @u.services_as_provider.where(s_status: 'sent')
          elsif params[:only] && params[:only] == 'done' 
            render json: @u.services_as_provider.where(s_status: 'done')
          else
            render json: @u.services_as_provider
          end
        end
      else
        render json: {error: 'user not found'}, status: 404
      end
    else
      render json: {error: 'request incompleto'}, status: 400
    end
  end


  def create
    if params[:name] && params[:provider] && (params[:location] == 'actual' || (params[:latitude] && params[:longitude]))
      
    else
      render json: {error: 'request incompleto'}, status: 400
    end
  end

end
