class ProjectsController < ApplicationController

  get '/projects' do
    @project = Project.all
    erb :'projects/show'
  end

  get '/projects/new' do
    erb :'projects/new'
  end

  post '/projects/new' do
    binding.pry
  end

  get '/projects/:id' do
    @project = Project.find(session[:user_id])
    erb :'projects/show'
  end

end
