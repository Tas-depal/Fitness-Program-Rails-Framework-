ActiveAdmin.register Program do

	permit_params :name, :status, :price, :video, :category_id, :user_id

	preserve_default_filters!

	filter :category, as: :select, collection: proc { Category.joins(:programs).pluck(:category_name, :id).uniq }, label: "Category" 
	filter :"user" , :as => :select, :collection => proc { User.joins(:programs).pluck(:name, :id).uniq }, label: "User"  
	remove_filter :purchases, :video_blob, :video_attachment

	index do
		selectable_column
		id_column
		column "Name", :name
		column "Status", :status
		column "Price", :price
    column "Category", sortable: 'categories.category_name' do |res|
      link_to res&.category&.category_name, admin_category_path(res.category_id)
    end
    column "User", sortable: 'users.name' do |res|
      link_to res&.user&.name, admin_user_path(res.user_id)
    end
		column :video do |vid|
      if vid.video.attached?
        video_tag rails_blob_path(vid.video, disposition: "attachment"), controls: true, class: 'my_video_size'
      else
        "No video attached"
      end
    end
  end

  form do |f|
  	f.inputs do
	    f.input :name
	    f.input :status
	    f.input :price
	    f.input :category, collection: Category.pluck(:category_name, :id).uniq
	    f.input :user, collection: User.where(type: 'Instructor').pluck(:name, :id).uniq
	    f.input :video, as: :file
	  end
	  f.actions
  end

  show do
    attributes_table do
      row :name
      row :status
      row :price
      row :category do |program|
	      link_to program.category.category_name, admin_category_path(program.category_id)
	    end
	    row :user
	    # row :video do |program|
      #   image_tag url_for(program.video), class: 'my_image_size'
      # end
      row :video do |vid|
        if vid.video.attached?
        video_tag rails_blob_path(vid.video, disposition: "attachment"), controls: true, width: "200", height: "200"
      else
        "No video attached"
      end
      end
    end
  end

end
