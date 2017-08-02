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
       @spot = Spot.create(content: params[:content], user_id: session[:user_id])
       redirect to "/spots"
     end
  end




end
