class Api::V1::ServiceStatusesController < ApplicationController

  def index
    if params[:name] && (@u = User.find_by(name: params[:name])) != nil && @u.user_t == 'user'
      if @u.services_as_user.any? && (@s = @u.services_as_user.take.service_status) != nil
        @p = @u.services_as_user.take.provider
          render json: {providerok: @s.providerok, userok: @s.userok, 
            user: {name: @u.name,  latitude: @u.location.latitude, longitude: @u.location.longitude}, 
            provider: {name: @p.name, latitude: @p.location.latitude, longitude: @p.location.longitude}}, status: 200
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
            @ss = @a.service_status
            @ss.userok = true
            if (@ss.save)
              render json: @ss, status: 200
            else
              render json: @ss, status: 500
            end
          else
            render json: @ss, status: 500
          end
        else
          if (@s = Service.where(user: @p, provider: @u)).any? && (@a = @s.take) != nil
            @ss = @a.service_status
            @ss.providerok = true
            if (haversine(@s.user.location.latitude, @s.user.location.longitude, @s.provider.location.latitude, @s.provider.location.longitude) < 500.0) &&  (@ss.save)
              render json: @ss, status: 200
            else
              render json: {errors: "Lugar incorrecto o no tienes servicio"}, status: 503
            end
          else
            render json: @ss, status: 501
          end
        end
      else
        render json: @ss, status: 500
      end
    end
  end

  def haversine(lat1, long1, lat2, long2)
    dtor = Math::PI/180
    r = 6378.14 * 1000

    rlat1 = lat1 * dtor
    rlong1 = long1 * dtor
    rlat2 = lat2 * dtor
    rlong2 = long2 * dtor

    dlong = rlong1 - rlong2
    dlat = rlat1 - rlat2

    a = power(Math::sin(dlat/2), 2) + Math::cos(rlat1) * Math::cos(rlat2) * power(Math::sin(dlon/2), 2)
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
    d = r * c

    return d
  end

  def power(num, pow)
    num ** pow
  end
end
