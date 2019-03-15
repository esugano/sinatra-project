class EmployeesController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'employees/create_employee'
    else
      redirect '/projects'
    end
  end

  post '/signup' do
  #check if all fields are filled to before moving forward
    if !params.has_value?("")
      @employee = Employee.create(name: params[:name], username: params[:username], password: params[:password])
      if login(@employee.id)
        #check if employee has any existing projects, otherwise, send to '/project/new'
        if @employee.projects == nil
          redirect '/project/new'
        else
          redirect '/employees'
        end
      else
        redirect '/signup'
      end
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/projects'
    else
      erb :'/employees/login'
    end
  end

  post '/login' do
    #check if all fields are filled to before moving forward
    if logged_in?
      redirect '/projects'
      redirect '/login'
    else
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
            redirect '/projects'
          else
            redirect '/login'
          end #51
        end #47
      end #42
    end #40
  end #38

  get '/employees' do
    if logged_in?
      @employees = Employee.all
      erb :'employees/index'
    else
      redirect '/login'
    end
  end

  get '/employees/:id' do
    if logged_in?
      @employee = Employee.find(params[:id])
      erb :'employees/show'
    else
      redirect '/login'
    end
  end

  get '/signout' do
    logout
    redirect '/login'
  end
end
