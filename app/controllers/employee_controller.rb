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
        redirect '/projects'
      else
        redirect '/signup'
      end
    else
      redirect '/signup'
    end
  end

  get '/employees' do
    @employees = Employee.all
    erb :'employees/index'
  end

  get '/employees/:id' do
    @employee = Employee.find(params[:id])
    erb :'employees/show'
  end

  get '/signout' do
    logout
    redirect '/signup'
  end
end
