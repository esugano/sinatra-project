class ProjectsController < ApplicationController

  get '/projects' do
    @project = Project.all
    erb :'projects/show'
  end

  get '/projects/:id' do
    @project = Project.find(session[:user_id])
    erb :'projects/show'
  end


end
