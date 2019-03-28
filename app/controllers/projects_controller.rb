class ProjectsController < ApplicationController

  get '/projects' do
    #check is user is logged_in
    redirect_if_not_logged_in
    @projects = Project.all
    erb :'projects/index'
  end

  get '/projects/new' do
    #check is user is logged_in
    redirect_if_not_logged_in
    erb :'projects/new'
  end

  post '/projects/new' do
    #check if all fields are filled
    if !params.has_value?("")
      @employee = current_employee
      @project = Project.create(name:params[:name],description:params[:description],hours:params[:hours].to_i)
      #make sure to add project to current employee!
      @employee.projects << @project
      redirect "/projects/#{@project.id}"
    else
      redirect '/projects/new'
    end
  end

  get '/projects/:id' do
    redirect_if_not_logged_in
    @project = Project.all.detect {|project| project.id == params[:id].to_i}
      #if project doesn't exist
    if @project == nil
      redirect '/projects'
    else
      erb :'projects/show'
    end
  end

  get '/projects/:id/edit' do
    redirect_if_not_logged_in
    @project = Project.find(params[:id])
    #project belongs to current_employee?
    if @project.employee_id == current_employee.id
      erb :'projects/edit'
    else
      redirect '/projects'
    end
  end

  patch '/projects/:id/edit' do
    if params.has_value?("")
      redirect "/projects/#{params[:id]}/edit"
    else
      redirect_if_not_logged_in
      #project belongs to current_employee?
      @project = Project.find(params[:id])
        if @project.employee_id == current_employee.id
          #update all project details & save to the database
          @project.name = params[:name]
          @project.description = params[:description]
          @project.hours = params[:hours].to_i
          @project.save
          redirect '/projects'
        else
          redirect '/projects'
        end
    end
  end

  delete '/projects/:id/delete' do
    #no need to validate as its already been done in previous routes/steps
    Project.find(params[:id]).delete
    redirect to '/projects'
  end

end
