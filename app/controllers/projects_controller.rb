class ProjectsController < ApplicationController

  get '/projects' do
    if !logged_in?
      redirect '/login'
    else
      @projects = Project.all
      erb :'projects/index'
    end
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
    if logged_in?
      @project = Project.all.detect {|project| project.id == params[:id].to_i}
      #if project doesn't exist
      if @project == nil
        #need to put in a message here
        redirect '/projects'
      else
        erb :'projects/show'
      end
    else
      redirect '/login'
    end
  end

  get '/projects/:id/edit' do
    if logged_in?
      #project belongs to current_employee?
      @project = Project.find(params[:id])
      if @project.employee_id == current_employee.id
        erb :'projects/edit'
      else
        redirect '/projects'
      end
    else
      redirect '/login'
    end
  end

  patch '/projects/:id/edit' do
    if params.has_value?("")
      redirect "/projects/#{params[:id]}/edit"
    else
      if logged_in?
        #project belongs to current_employee?
        @project = Project.find(params[:id])
        if @project.employee_id == current_employee.id
          @project.name = params[:name]
          @project.description = params[:description]
          @project.hours = params[:hours].to_i
          @project.save
          redirect '/projects'
        else
          redirect '/projects'
        end
      else
        redirect '/login'
      end
    end
  end

  delete '/projects/:id/delete' do
    @project = Project.find(params[:id])
    @project.delete if @project.employee_id == current_employee.id
    redirect to '/projects'
  end

end
