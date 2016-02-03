module API
  module V1
    class UsersController < ApplicationController
      skip_before_action :verify_authenticity_token

      before_action :logged_in_user,     only: [:index, :edit, :update]
      before_action :correct_user,       only: [:edit, :update]
      before_action :admin_user,         only: :destroy

      def index
        @users = User.paginate(page: params[:page])
      end
      
      def show
        @user = User.find(params[:id])
      end
      
      def new
        @user = User.new
      end
      
      def create
        @user = User.new(user_params)
        if @user.save
          log_in @user
          render :create, status: 200, location: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end
      
      def destroy
        User.find(params[:id]).destroy
        render nothing: true, status: 204
      end

      private
        
        def user_params
          params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end
        
        # Before filters
        
        # Confirms the correct user.
        def correct_user
          @user = User.find(params[:id])
          unless current_user?(@user)
            format.json {render json: 'Bad credentials', status: 401}
          end
        end
        
        # Confirms an admin user.
        def admin_user
          unless current_user.admin?
            format.json {render json: 'Bad credentials', status: 401}
          end
        end
    end
  end
end