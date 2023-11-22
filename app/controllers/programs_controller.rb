class ProgramsController < ApiController

  before_action :authorize_user
  before_action :find_id, only: [ :show, :update, :destroy ]
  before_action :active_program, only: [ :show_active_program, :show_category_wise_programs ]

# .................Instructor Functionalities....................
# ...................Show programs....................
  def index
  	program = @current_user.programs
    if program
      render json: program
    else
      render json: { message: "No programs exists for this instructor" }
    end 	
  end

# ...................Create program....................
  def create
    program = @current_user.programs.new(set_params)
    if program.save
      render json: program 
    else
      render json: { errors: program.errors.full_messages }
    end
  end

# ..............Show particular program................
  def show
		render json: @program
  end

# ...................Update program....................
  def update
    if @program.update(set_params)
      render json: @program 
    else
      render json: { errors: program.errors.full_messages }     
    end
  end

# .....................Destroy program.....................
  def destroy
    @program.destroy
    render json: { message: 'Deleted successfully' }
  end

# ..............Search program through name.....................
  def search_program_name
    unless params[:name].present?
      render json: { message: 'No record found...' }
    else
    	program = @current_user.programs.where("name like ?", "%"+ params[:name].strip+"%")
      if program.empty?
        render json: { message: 'No data found...' }
      else
        render json: program
      end
    end
  end

# ..............Search program through status.....................
  def search_program_status
    unless params[:status].present?
      render json: { message: 'No record found...' }
    else
      program = @current_user.programs.where("status like '%#{params[:status].strip}%'")
      if program.empty?
        render json: { message: 'No data found...' }
      else
        render json: program
      end
    end
  end

# .................Delete Customer Program............................
  def delete_customer_purchase
    if params[:program_id].present? && params[:purchase_id].present?
      program = @current_user.programs.joins(:purchases).where("programs.id = #{ params[:program_id] } AND purchases.id = #{ params[:purchase_id] }")
      if program.empty?
        render json: {message: "Record not found"}        
      else
        purchase = Purchase.find_by_id(params[:purchase_id])
        purchase.destroy
        render json: { message: "Purchase deleted successfully" }
      end
    else
      render json: { message: "Record not found" }
    end
  end

# .................Customer Functionalities....................
# .....................Show active programs....................
  def show_active_program   
  end

# .....................Show category wise programs.............
  def show_category_wise_programs
  end

# ....................Search category and name wise programs.............
  def search_by_category_and_name
    if params[:name].present?
      program = Program.joins(:category).where("category_name like '%#{ params[:name].strip }%' OR name like '%#{ params[:name].strip }%' and status='active'")
      if program.empty?
        render json: { message: "No data found" }
      else
        render json: program
      end
    else
      render json: { message: "Please provide required field" }
    end
  end

# ..................Search in purchased Programs.......................
  def search_in_customer_program
    if params[:name].present?
      program = Purchase.joins(:program).where("purchases.user_id=#{ @current_user.id } AND name LIKE '%#{ params[:name].strip }%'")
      if program.empty?
        render json: { error: 'Record not found' }
      else
        render json: program
      end
    else
      render json: { message: "Please provide required field" }
    end
  end

	private
    def set_params
      params.permit(:name,:status,:price,:video,:category_id)
    end

    def find_id
      @program = @current_user.programs.find_by_id(params[:id])
      unless @program
        render json: "Id not found.." 
      end   
    end

    def active_program
      program = Program.where(status: 'active')
      unless program.empty?
        render json: program
      else
        render json: { message: 'No data found...' }
      end
    end

    def authorize_user
      authorize Program
    end
end
