module Api  
  class CategoriesController < ApiController

    before_action :find_id, except: [:index, :create]
    skip_before_action :authenticate_user!

  # ..................Show all categories................... 
    def index
      category = Category.all 
      return render json: { message: "There are no categories available.." } if category.empty?    
      return render json: category if category
  end

  # ..................Create category......................
    def create
      category = Category.new(set_params)
      return render json: category if category.save
      return render json: { error: category.errors.full_messages }
    end

  # ..................Update category......................
    def update
      return render json: { message: 'Updated successfully', data: @category } if @category.update(set_params)
      return render json: { message: @category.errors.full_messages }      
    end

  # ..................Delete category......................
    def destroy
      return render json: { message: 'Deleted successfully', data: @category } if @category.destroy
    end

  # ..................Show category.........................
    def show
      render json: @category
    end

    private 
      def set_params
        params.permit(:category_name)
      end

      def find_id
        @category = Category.find_by(id: params[:id])
        unless @category
          render json: "Id not found.." 
        end   
      end
  end
end