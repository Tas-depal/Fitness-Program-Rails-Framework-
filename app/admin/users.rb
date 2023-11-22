ActiveAdmin.register User do
  permit_params :name, :email, :contact_no

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :contact_no
    end
    f.actions
  end  
end
