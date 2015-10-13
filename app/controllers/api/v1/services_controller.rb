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
    if params[:name] && params[:provider] && params[:latitude] && params[:longitude] && params[:message]
      @s = Service.new
      @s.s_date = Time.now()
      @s.user = User.find_by(name: params[:name])
      @s.provider = User.find_by(name: params[:provider])
      @s.latitude = params[:latitude]
      @s.longitude = params[:longitude]
      @s.s_t = 'sent'
      @s.message = params[:message]
      if(@s.save)
        @ss = ServiceStatus.new
        @ss.service = @s
        @ss.status = 'false'
        if @ss.save    
          render json: @s, status: 200
        else
          render json: {error: 'error'}, status: 500
        end
      else
        render json: {error: 'error'}, status: 500
      end
    else
      render json: {error: 'request incompleto'}, status: 400
    end
  end

end
