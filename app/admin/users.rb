ActiveAdmin.register User do
	permit_params :name, :email, :contact_no, :password_digest, :type

	preserve_default_filters!

	remove_filter :purchases, :programs

	form do |f|
		f.inputs do
			f.input :name
			f.input :email
			f.input :contact_no
			f.input :type
			f.input :password_digest
		end
		f.actions
	end
end
