class SessionsController < ApplicationController


	def create
		session[:flag] = nil
		if Lender.find_by_email(params[:email])
			user = Lender.find_by_email(params[:email])
			session[:flag] = 1
		else
			user = Borrower.find_by_email(params[:email])
			session[:flag] = 0
		end

		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			if session[:flag] == 1
				redirect_to "/lenders/#{session[:user_id]}"
			elsif session[:flag] == 0
				redirect_to "/borrowers/#{session[:user_id]}"
			else
				redirect_to '/'
			end
		else
			flash[:errors] = ["Invalid combination"]
			redirect_to '/login'
		end
	end

  def destroy
    session[:user_id] = nil
    session[:flag] = nil
    redirect_to '/'
  end

end
