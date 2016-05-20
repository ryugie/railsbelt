class HistoriesController < ApplicationController
	before_action :require_login
	
	def create
		@current = current_user.money
		if params[:lendamount].to_i > @current
			flash[:funds] = "Insufficient Funds"
			redirect_to :back
		else
			@newmoney = @current - params[:lendamount].to_i
			Lender.find(current_user.id).update(money: @newmoney)
			History.create(amount: "#{params[:lendamount]}", lender_id: current_user.id, borrower_id: "#{params[:lendee]}")
			@total = History.select(:amount, :borrower_id).where("borrower_id = #{params[:lendee]}")
			totalraised = 0
			@total.each do |t|
				totalraised += t.amount
			end
			Borrower.find("#{params[:lendee]}").update(raised: totalraised)
			redirect_to :back
		end
	end

	private
	def history_params
		params.require(:history).permit(:amount)
	end
end
