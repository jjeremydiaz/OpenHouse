class UsersController < ApplicationController
    def user_params
        params.require(:user).permit(:username, :password, :name, :email, :credit_card_number, :address)
    end

    def new
        #show create new user template
    end
    
    def create
        @user = User.find_by(username: params[:user][:username])
        if @user != nil
            flash[:alert] = "Username #{@user.username} already taken."
            redirect_to new_user_path and return
        end
        
        @user = User.create!(user_params)
        flash[:alert] = "Account #{@user.username} was successfully created."
        session[:username] = @user.username
        redirect_to login_path
    end
end
