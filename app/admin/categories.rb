ActiveAdmin.register Category do

  permit_params :category_name
  preserve_default_filters!

  remove_filter :programs  
end
