class Api::V1::UsersController < ApplicationController

  def index
    if params[:id]
      if (@u = User.find_by_id(params[:id])) != nil
        render json: @u
      else
        render :json => { :error => "gigante" }
      end
    else
      @u = User.find(1)
      render json: @u
    end
  end

end
