module Api  
  class CategoriesController < ApiController

    before_action :find_id, except: [:index, :create]
    skip_before_action :authenticate_request

  # ..................Show all categories................... 
    def index
      category=Category.all 
      if category
        render json: category
      else
        render json: { message: "There are no categories available.." }      
      end
    end

  # ..................Create category......................
    def create
      category = Category.new(set_params)
      if category.save
        render json: category
      else
        render json: { error: category.errors.full_messages }
      end
    end

  # ..................Update category......................
    def update
      if @category.update(set_params)
        render json: { message: 'Updated successfully', data: @category }
      else
        render json: { message: @category.errors.full_messages }      
      end
    end

  # ..................Delete category......................
    def destroy
      if @category.destroy
        render json: { message: 'Deleted successfully', data: @category }
      else
        render json: { message: 'No such data exists to be deleted' }      
      end
    end

  # ..................Show category.........................
    def show
      if @category
        render json: @category
      else
        render json: { message: 'Data with #{params[:id]} does not exist..' }     
      end    
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