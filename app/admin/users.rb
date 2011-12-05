ActiveAdmin.register User do
  menu :parent => "Users"

  index do
    column :email
    default_actions
  end

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :confirm_password
    end
    f.buttons
  end

end

