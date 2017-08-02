class SpotsController < ApplicationController

  get '/spots' do
    if logged_in?
      @spots = Spot.all
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
     if params[:content] == ""
       redirect to '/spots/new'
     else
       @spot = Spot.create(date: params[:date], time: params[:time], address: params[:address], floor: params[:floor], section: params[:section], row: params[:row], spot: params[:spot], note: params[:note], user_id: session[:user_id])
       redirect to "/spots"
     end
  end


end
