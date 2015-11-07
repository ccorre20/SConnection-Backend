class Api::V1::ServicesController < ApplicationController

  def index
    if params[:name]
      if (@u = User.find_by name: params[:name]) != nil
        if (@u.user_t == 'user')
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
    if params[:name] && params[:provider] && params[:latitude] && params[:longitude] && params[:message] && params[:type]
      @s = Service.new
      @s.s_date = Time.now()
      if (@u = User.find_by(name: params[:name])) != nil && (@p = User.find_by(name: params[:provider])) != nil
        @s.user = @u
        @s.provider = @p
        @s.latitude = params[:latitude]
        @s.longitude = params[:longitude]
        @s.s_status = 'sent'
        @s.message = params[:message]
        @s.s_t = params[:type]
        if (Service.where(user: @u, provider: @p).any? == false && (@s.save)
          @ss = ServiceStatus.new
          @ss.service = @s
          @ss.status = 'PENDING'
          @ss.userok = false
          @ss.providerok = false
          if @ss.save    
            render json: @s, status: 200
          else
            @s.delete
            render json: {error: 'error'}, status: 500
          end
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
