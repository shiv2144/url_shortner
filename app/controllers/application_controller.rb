class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
    include SessionsHelper

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
      	format.json {render json: 'Bad credentials', status: 401}
      end
    end
end