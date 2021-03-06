require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "park_spot_secret"
  end

  get "/" do
    if logged_in?
      redirect '/spots'
    else
      erb :index
    end
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
       User.find_by(id: session[:user_id])
    end
  end

end
