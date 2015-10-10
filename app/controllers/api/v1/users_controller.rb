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

end
