Specs:

 Use Sinatra to build the app
  - Yes, see Gemfile
 Use ActiveRecord for storing information in a database
  - Yes, see db/schema.rb
 Include more than one model class (e.g. User, Post, Category)
  - Yes, Employees and Projects classes
 Include at least one has_many relationship on your User model (e.g. User has_many Posts)
  - Employees has many Projects
 Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
  - A project belongs to an Employee
 Include user accounts with unique login attribute (username or email)
  - Yes, see app/controllers/employee_controller.rb, line 15
 Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
  - Yes, see app/controllers/projects_controller.rb, lines 13 on
 Ensure that users can't modify content created by other users
  - Yes, see app/controllers/projects_controller.rb, lines 53 as an example
 Include user input validations
  - Yes, see app/controllers/projects_controller.rb, lines 64 as an example
 BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
 Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code - WIP
Confirm

 You have a large number of small Git commits - 20+ commits
 Your commit messages are meaningful - I hope so :)
 You made the changes in a commit that relate to the commit message - Yes
 You don't include changes in a commit that aren't related to the commit message - I don't think so
