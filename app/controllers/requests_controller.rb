class RequestsController < ApplicationController
    before_action :set_request, except: [:index]
    before_action :check_participating!, except: [:index]
    
    def new
      redirect_to request_path(@request) and return if @request
      @message = current_user.messages.build
    end
  
    private
    
    def find_request!
      if params[:receiver_id]
        @receiver = User.find_by(id: params[:receiver_id])
        redirect_to(root_path) and return unless @receiver
        @request = request.between(current_user.id, @receiver.id)[0]
      else
        @request = request.find_by(id: params[:request_id])
        redirect_to(root_path) and return unless @request && @request.participates?(current_user)
      end
    end
    
    def show
      @message = Message.new
    end
    
    private
    
    def set_request
      @request = request.find_by(id: params[:id])
    end
    
    def check_participating!
      redirect_to root_path unless @request && @request.participates?(current_user)
    end
    
    def index
      @requests = Request.participating(current_user).order('updated_at DESC')
    end
end
