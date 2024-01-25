ActiveAdmin.register Purchase do

	permit_params :user_id, :program_id
	
	preserve_default_filters!

	filter :program_id, as: :select, collection: proc { Category.joins(programs: [:purchases]).distinct.pluck(:category_name, :id) }, label: "Category" 
	filter :"user" , :as => :select, :collection => proc { User.joins(:purchases).pluck(:name, :id).uniq }, label: "User"  
	filter :"program" , :as => :select, :collection => proc { Program.joins(:purchases).pluck(:name, :id).uniq }, label: "Program"  

	index do
		selectable_column
		id_column
		column "Status", :status
		column "Amount", :amount
		column "Program", :program
		column "Category" do |purchase|
			link_to Category.find_by(id: purchase.program.category_id).category_name, admin_category_path(purchase.program.category_id)
		end
		column "User", sortable: 'users.name' do |res|
			link_to res&.user&.name, admin_user_path(res.user_id)
		end
		actions
	end

	form do |f|
		f.inputs do
			f.input :user, collection: User.where(type: 'Customer').pluck(:name, :id).uniq
			f.input :program, collection: Program.where(status: "active").pluck(:name, :id).uniq
		end
		f.actions
	end

	show do
		attributes_table do
			row :user
			row :status
			row :amount
			row :program
			row :category do |purchase|
				link_to Category.find_by(id: purchase.program.category_id).category_name, admin_category_path(purchase.program.category_id)
			end
			row :created_at
			row :updated_at
		end
	end  

	controller do
    def create
      purchase = Purchase.new(permitted_params[:purchase])
      program = Program.find_by(status: 'active' , id: purchase.program_id)
	    if purchase.save
				purchase.update(status: 'started', amount: program.price)
	      redirect_to admin_purchase_path(purchase.id)
	    end
    end
  end
end
