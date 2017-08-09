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
     if params[:name] == "" || params[:date] == "" || params[:time] == "" || params[:address] == "" || params[:floor] == "" || params[:section] == "" || params[:row] == "" || params[:spot] == ""
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

  get '/spots/:id/edit' do
    if logged_in?
      @spot = Spot.find_by_id(params[:id])
        erb :'/spots/edit_spot'
      else
      redirect to '/login'
    end
  end

  post '/spots/:id' do
    if params[:name] == "" || params[:date] == "" || params[:time] == "" || params[:address] == "" || params[:floor] == "" || params[:section] == "" || params[:row] == "" || params[:spot] == ""
      redirect to "/spots/#{params[:id]}/edit"
    else
      @spot = Spot.find_by_id(params[:id])
      @spot.name = params[:name]
      @spot.date = params[:date]
      @spot.time = params[:time]
      @spot.address = params[:address]
      @spot.floor = params[:floor]
      @spot.section = params[:section]
      @spot.row = params[:row]
      @spot.spot = params[:spot]
      @spot.note = params[:note]
      @spot.save
      redirect to "/spots"
    end
  end

  post '/spots/:id/delete' do
      if logged_in?
        @spot = Spot.find_by_id(params[:id])
        if @spot.user_id == current_user.id
          @spot.delete
          redirect to '/spots'
        end
        redirect to '/login'
      end
    end


end
