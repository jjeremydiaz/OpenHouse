class MessagesController < ApplicationController
  before_action :find_request!

  def new
    redirect_to request_path(@request) and return if @request
    @message = current_user.messages.build
  end

  def create
    @request ||= request.create(sender_id: current_user.id,
                                          recipient_id: @recipient.id)
    @message = current_user.messages.build(message_params)
    @message.request_id = @request.id
    @message.save!

    flash[:success] = "Your message was sent!"
    redirect_to request_path(@request)
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def find_request!
    if params[:recipient_id]
      @recipient = User.find_by(id: params[:recipient_id])
      redirect_to(root_path) and return unless @recipient
      @request = Request.between(current_user.id, @recipient.id)[0]
    else
      @request = Request.find_by(id: params[:request_id])
      redirect_to(root_path) and return unless @request && @request.participates?(current_user)
    end
  end
end
