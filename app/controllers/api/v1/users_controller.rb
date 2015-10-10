class Api::V1::UsersController < ApplicationController

  def index
    if params[:login] && params[:login] == 'true' && params[:name] 
      if (@u = User.find_by name: params[:name]) != nil
        render json: @u , status: 200
      else
        render json: { error: "usuario inexistente"}, status: 404
      end
    else
      render json: { error: "request incompleto" }, status: 400
    end
  end


  def create
    if params[:name] && params[:user_t]
      @u = User.new
      @u.name = params[:name]
      if ['user', 'provider'].include?(params[:user_t])
        @u.user_t = params[:user_t]
        if @u.save
          render json: @u, status: 200
        else
          render json: @u.errors, status: 500
        end
      else
        render json: { error: "tipo incorrecto" }, status: 400  
      end
    else
      render json: { error: "faltan parametros" }, status: 400
    end
  end

end
