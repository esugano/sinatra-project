class UsersController < ApplicationController

  get '/users' do
    @user = User.all
    erb :'users/show'
  end

end
