require './config/environment'


use Rack::MethodOverride
use EmployeesController
use ProjectsController
run ApplicationController
