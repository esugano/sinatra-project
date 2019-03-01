require './config/environment'


use Rack::MethodOverride
use CompaniesController
use ProjectsController
run ApplicationController
