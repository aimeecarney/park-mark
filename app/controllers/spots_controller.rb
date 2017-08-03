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
       @spot = Spot.create(name: params[:name], date: params[:date], time: params[:time], address: params[:address], floor: params[:floor], section: params[:section], row: params[:row], spot: params[:spot], note: params[:note], user_id: session[:user_id])
       redirect to "/spots"
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

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
        erb :'/tweets/edit_tweet'
      else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content] == ""
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect to '/tweets'
      end
      redirect to '/login'
    end
  end


end
