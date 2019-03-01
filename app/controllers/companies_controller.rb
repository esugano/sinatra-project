class CompaniesController < ApplicationController

  get '/signup' do
    erb :'users/create_user'
  end

end
