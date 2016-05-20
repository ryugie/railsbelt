class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    if session[:flag] == 1
      Lender.find(session[:user_id]) if session[:user_id]
    elsif session[:flag] == 0
      Borrower.find(session[:user_id]) if session[:user_id]
    end
  end
  
  helper_method :current_user

  def require_login
    redirect_to '/login' if session[:user_id] == nil
  end
  
  def require_correct_user
    if session[:flag] == 1
      user = Lender.find(params[:id])
    elsif session[:flag] == 0
      user = Borrower.find(params[:id])
    end
    redirect_to '/' if current_user != user
  end
end
