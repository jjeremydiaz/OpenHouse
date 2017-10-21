class ProfilesController < ApplicationController
    
    def edit
        
        @current_user = session[:user]
        
        if not signed_in?
            redirect_to sign_in_path
        end
    end
    
    def update
        
    end
end
