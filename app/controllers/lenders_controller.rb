class LendersController < ApplicationController
	before_action :require_login, except: [:index, :index2, :new, :create]
	before_action :require_correct_user, only: [:show]

	def index
	end

	def index2
	end

	def show
		@help = Borrower.all # edit this later
		@lent = History.joins(:lender).joins(:borrower).select(:id,
			"lenders.first_name as lf_name", "lenders.last_name as ll_name",
			"borrowers.first_name as bf_name", "borrowers.last_name as bl_name",
			:purpose, :description, "borrowers.money as b_money", :raised, :amount).where("lender_id = #{current_user.id}")
		# @raised = History.joins(:borrower).select(:id, :amount).where("borrower_id = ")
	end

	def create
		@lender = Lender.new(lender_params)
	    if @lender.save
	      	redirect_to '/login'
	    else
			flash[:errors] = @lender.errors.full_messages
			redirect_to :back
	    end
	end

	private
	def lender_params
		params.require(:lender).permit(:first_name, :last_name, :email, :password, :password_confirmation, :money)
	end

	
end



# class Product < asdf
# 	def self.all_products
# 		self.joins(:category).select(:id, “products.name as p_name”, :description, :pricing, “categories.name as c_name”)
# 	end
# end

# Product.joins(:category).select(:id, “products.name as p_name”, :description, :pricing, “categories.name as c_name”)
# :id will refer to Products, don’t need to be explicit

# class ProductsController < asdf
# 	def index
# 		@products = Product.all_products
# 	end
# end

