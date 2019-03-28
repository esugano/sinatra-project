class EmployeesController < ApplicationController

  get '/signup' do
    #is the user already logged_in?r
    if !logged_in?
      erb :'employees/create_employee'
    else
      redirect "/employees/#{current_employee.id}"
    end
  end

  post '/signup' do
  #check if all fields are filled to before moving forward
    if !params.has_value?("")
      if Employee.find_by(username: params[:username]) == nil
        @employee = Employee.create(name: params[:name], username: params[:username], password: params[:password])
        #check if employee has any existing projects, otherwise, send to '/project/new'
        if @employee.projects == nil
          redirect '/project/new'
        else
          login(@employee.id)
          redirect "/employees/#{current_employee.id}"
        end
      else
        redirect '/login'
      end
    else
      redirect '/signup'
    end
  end

  get '/login' do
    #if already logged_in, send to /projects
    if logged_in?
      redirect "/employees/#{current_employee.id}"
    else
      erb :'/employees/login'
    end
  end

  post '/login' do
    #check if all fields are filled to before moving forward
    if params.has_value?("")
      redirect '/login'
    else
      @employee = Employee.find_by(username: params[:username])
      #does employee exist?
      if @employee  == nil
          redirect '/login'
      else
        #password is corrected?
        if @employee && @employee.authenticate(params[:password])
          login(@employee.id)
          redirect "/employees/#{current_employee.id}"
        else
          redirect '/login'
        end #51
      end #47
    end #42
  end #38

  get '/employees' do
    redirect_if_not_logged_in
    @employees = Employee.all
    erb :'employees/index'
  end

  get '/employees/:id' do
    redirect_if_not_logged_in
    @employee = Employee.find(params[:id])
    erb :'employees/show'
  end

  get '/signout' do
    logout
    redirect '/login'
  end
end
