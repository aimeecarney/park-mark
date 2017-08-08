require 'pry'

class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/spots'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/signup'
    else
      user = User.new(email: params[:email], username: params[:username], password: params[:password])
      user.save
      session[:user_id] = user.id
      redirect '/spots'
    end
  end

    get '/login' do
      if logged_in?
        redirect to '/spots'
      else
        erb :'/users/login'
      end
    end

    post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect '/spots'
      else
        redirect '/signup'
      end
    end

    get '/logout' do
      if logged_in?
        session.clear
        redirect '/'
      else
        redirect '/'
      end
    end

    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      @spots = @user.spots
      erb :'users/show'
    end

end
