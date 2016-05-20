class BorrowersController < ApplicationController
	before_action :require_login, except: [:index, :index2, :new, :create]
	before_action :require_correct_user, only: [:show]

	def index
	end

	def show
		@lent = History.joins(:lender).joins(:borrower).select(:id,
			"lenders.first_name as lf_name", "lenders.last_name as ll_name", "lenders.email as lemail",
			"borrowers.first_name as bf_name", "borrowers.last_name as bl_name",
			:purpose, :description, "lenders.money as b_money", :raised, :amount).where("borrower_id = #{current_user.id}")
	end



	def create
		@borrower = Borrower.new(borrower_params)
	    if @borrower.save
	      	redirect_to '/login'
	    else
			flash[:errors] = @borrower.errors.full_messages
			redirect_to :back
	    end
	end

	private
	def borrower_params
		params.require(:borrower).permit(:first_name, :last_name, :email, :password, :password_confirmation, :money, :purpose, :description, :raised)
	end
end