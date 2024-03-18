ActiveAdmin.register User do

  permit_params :name, :username, :email, :password, :password_confirmation

end
