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
    user = User.new(params[:user])
    if user.save
      session[:user_id] = user.id
      redirect '/spots'
    else
      erb :'users/create_user'
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
      @user = User.find_by(username: params[:username], email: params[:email])
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

end
