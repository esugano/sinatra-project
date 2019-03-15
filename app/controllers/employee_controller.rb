class EmployeesController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'employees/create_employee'
    else
      redirect '/projects'
    end
  end

  post '/signup' do
    if !params.has_value?("")
      @employee = Employee.create(name: params[:name], username: params[:username], password: params[:password])
      if login(@employee.id)
        redirect '/employees'
      else
        redirect '/signup'
      end
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/employees'
    else
      redirect '/login'
    end
  end

  get '/employees' do
    if logged_in?
      @employees = Employee.all
      erb :'employees/index'
    else
      redirect '/signup'
    end
  end

  get '/employees/:id' do
    if !logged_in?
      @employee = Employee.find(params[:id])
      erb :'employees/show'
    else
      redirect '/signup'
    end
  end

  get '/signout' do
    logout
    redirect '/signup'
  end
end
