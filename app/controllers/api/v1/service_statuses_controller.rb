class Api::V1::ServiceStatusesController < ApplicationController

  def index
    if params[:name] && (@u = User.find_by(name: params[:name])) != nil && @u.user_t == 'user'
      if @u.services_as_user.any? && (@s = @u.services_as_user.take.service_status) != nil
          render json: @s.providerok, status: 200
      else
        render json: {error: 'no hay servicio o estado'}, status: 500
      end
    else
      render json: {error: 'usuario no encontrado o es proveedor'}, status: 500
    end
  end


  def create
    if params[:name] && params[:only]
      if (@u = User.find_by(name: params[:name])) != nil && (@o = User.find_by(name: params[:only])) != nil 
        if(@u.user_t == 'user') && (@s = Service.where(user: @u, provider: @p)).any?
          if (@a = @s.take) != nil
            @a.userok = true
            if (@a.save)
              render json: @a, status: 200
            else
              render json: @a, status: 500
            end
          else
            render json: @a, status: 500
          end
        else
          if (@s = Service.where(user: @p, provider: @u)).any? && (@a = @s.take) != nil
            @a.providerok = true
            if (@a.save)
              render json: @a, status: 200
            else
              render json: @a, status: 500
            end
          else
            render json: @a, status: 500
          end
        end
      else
        render json: @a, status: 500
      end
    end
  end

end
