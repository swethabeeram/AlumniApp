ActiveAdmin.register Course do

  index do
    column "Course Name", :name
    column "Created Date", :created_at
  default_actions
  end  
end
