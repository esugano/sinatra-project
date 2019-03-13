class ProjectsController < ApplicationController

  get '/projects' do
    @project = Project.all
    @employee = current_employee
    erb :'projects/show'
  end

  get '/projects/new' do
    if logged_in?
      erb :'projects/new'
    else
      redirect '/signup'
    end
  end

  post '/projects/new' do
    if !params.has_value?("")
      @employee = current_employee
      @project = Project.create(name:params[:name],description:params[:description],hours:params[:hours].to_i)
      @employee.projects << @project
      erb :'projects/show'
    else
      redirect '/projects/new'
    end
  end

  get '/projects/:id' do
    @project = Project.find(session[:user_id])
    erb :'projects/show'
  end

end
