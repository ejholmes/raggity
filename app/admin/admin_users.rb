ActiveAdmin.register AdminUser do

  index do
    column :email
    default_actions
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
    end
    f.buttons
  end

end
