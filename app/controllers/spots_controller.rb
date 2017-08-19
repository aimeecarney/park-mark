require 'pry'

class SpotsController < ApplicationController

  get '/spots' do
    if logged_in?
      @spots = current_user.spots
      erb :'spots/spots'
    else
      redirect to '/users/login'
    end
  end

  get '/spots/new' do
    if logged_in?
      erb :'/spots/create_spot'
    else
      redirect to '/login'
    end
  end

  post '/spots' do
     @spot = current_user.spots.build(params[:spot])
     if @spot.save
       redirect to "/spots"
     else
       erb :'/spots/create_spot'
     end
  end

  get '/spots/:id' do
    if logged_in?
      @spot = Spot.find_by_id(params[:id])
      erb :"/spots/show_spot"
    else
      redirect to '/login'
    end
  end

  get '/spots/:id/edit' do
    if logged_in?
      @spot = Spot.find_by_id(params[:id])
        erb :'/spots/edit_spot'
      else
      redirect to '/login'
    end
  end

  patch '/spots/:id' do
    if logged_in?
      if @spot = current_user.spots.find_by_id(params[:id])
        if @spot.update(params)
          redirect to "/spots"
        else
          erb :'/spots/edit_spot'
        end
      else
        redirect '/spots'
      end
    else
      redirect '/login'
    end
  end

  delete '/spots/:id' do
    if logged_in?
      if @spot = Spot.find_by_id(params[:id]) && @spot.user_id == current_user.id
        @spot.delete
      end
      redirect to '/spots'
    else
      redirect to '/login'
    end
  end

end
