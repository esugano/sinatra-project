require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :'homepage'
  end

  helpers do

    def logged_in?
      session[:user_id] != nil
    end

    def current_user
      if logged_in?
        User.find(session[:user_id])
      end
    end

    def login (user_id)
      session[:user_id] = user_id
    end

  	def logout
      session.clear
    end
  end

end
