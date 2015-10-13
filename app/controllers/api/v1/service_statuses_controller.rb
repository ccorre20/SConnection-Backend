class Api::V1::ServiceStatusesController < ApplicationController

  def index
  end


  def create
    if params[:name] && params[:status]
      if (@u = User.find_by(name: params[:name])) != nil && (@s = @u.services_as_provider.take != nil)
        if @s.service_status.take == nil
          @ss = ServiceStatus.new
          @ss.service = @s
          @ss.status = params[:status]
          if @ss.save
            render json: @ss, status: 200
          else
            render json: {error: 'no se puede actualizar'}, status: 500 
          end
        else
          @ss = @s.service_status
          @ss.status = params[:status]
          if @ss.save
            render json: @ss, status: 200
          else
             render json: {error: 'no se puede actualizar'}, status: 500 
          end
        end
      else
        render json: {error: 'error hallando servicio'}, status: 404
      end
    else
      render json: {error: 'parametros incorrectos'}, status: 400
    end
  end

end
