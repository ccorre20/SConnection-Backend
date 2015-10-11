class Api::V1::LocationsController < ApplicationController

  def index
    if params[:name]
      if (@u = User.find_by name: params[:name]) != nil && @u.location != nil
        render json: @u.location, status: 200
      else
        render json: { error: "nombre o ubicacion no encontrada" }, status: 404
      end     
    else
      render json: { error: "request incompleto" }, status: 400
    end
  end


  def create
    if params[:name] && params[:latitude] && params[:longitude]
      if (@u = User.find_by name: params[:name]) != nil
        if (@u.location == nil)
          @l = Location.new
          @l.user = @u
          @l.latitude = params[:latitude]
          @l.longitude = params[:longitude]
          if @l.save
            render json: @l, status: 200
          else
            render json: @l.errors, status: 500
          end
        else
          @l = @u.location
          @l.latitude = params[:latitude]
          @l.longitude = params[:longitude]
          if @l.save
            render json: @l, status: 200
          else
            render json: @l.errors, status: 500
          end
        end
      else
        render json: {error: "user not found"}, status: 404
      end
    else
      render json: {error: "request incompleto"}, status: 400
    end
  end

end
