class Api::V1::ServiceStatusesController < ApplicationController

  def index
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
