class Company < ActiveRecord::Base
  has_many :projects
  has_secure_password
end
