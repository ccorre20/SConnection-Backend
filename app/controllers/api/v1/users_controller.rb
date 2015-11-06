class Api::V1::UsersController < ApplicationController

  def index
    if params[:login] && params[:login] == 'true' && params[:name] && params[:password]
      if (@u = User.find_by name: params[:name]) != nil
        if(@u.password = params[:password])
          render json: @u , status: 200
        else
          render json: { error: "usuario inexistente"}, status: 404
        end
      else
        render json: { error: "usuario inexistente"}, status: 404
      end
    elsif params[:only]
      if params[:only] == 'provider'
        @ulist = User.where(user_t: 'provider')
        render json: @ulist, status: 200
      elsif params[:only] == 'user'
        @ulist = User.where(user_t: 'user')
        render json: @ulist, status: 200
      else
        render json: { error: "tipo incorrecto" }, status: 400
      end
    elsif params[:name] && params[:ranking] == 'true'
      if (@u = User.find_by name: params[:name]) != nil &&  (@u.user_t == 'provider') && @u.provider_profile_as_provider != nil
        render json: @u.provider_profile_as_provider.ranking, status: 200
      else
        render json: @u, status: 500
      end
    else
      render json: { error: "request incompleto" }, status: 400
    end
  end


  def create
    if params[:name] && params[:user_t] && params[:password]
      @u = User.new
      @u.name = params[:name]
      @u.password = params[:password]
      if ['user', 'provider'].include?(params[:user_t])
        @u.user_t = params[:user_t]
        @u.realname = params[:name]
        @u.avail = 'true'
        if @u.save
          if @u.user_t == 'provider'
            if params[:description] && params[:availability]
              @p = ProviderProfile.new
              @p.provider = @u
              @p.description = params[:description]
              @p.availability = params[:availability]
              @p.rating = 0.0
              if @p.save
                render json: @u, status: 200
              else
                @u.delete
                render json: @u, status: 501
              end
            else
              @u.delete
              render json: @u, status: 502
            end
          else
            render json: @u, status: 200
          end
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

