class Api::MessagesController < ApplicationController
    before_action :authenticate_user!
    
    def index 
        if current_user.is_admin
            if params[:q]
              @messages = Message.where("MATCH(body) AGAINST(? IN BOOLEAN MODE)", params[:q] + "*")
              render json: {messages: @messages, success: true}
            elsif @messages = Message.all
                render json: {messages: @messages, success: true}
            else
                render json: {success: false, error: [@messages.errors]}
            end
        else
            if params[:q]
              @messages = Message.where("MATCH(body) AGAINST(? IN BOOLEAN MODE)", params[:q] + "*")
              render json: {messages: @messages, success: true}
            elsif @messages = current_user.conversation.last.messages
                render json: {messages: @messages, success: true}
            else
                render json: {success: false, error: [@messages.errors]}
            end
        end
    end

    def show
        if @message = current_user.message.find(params[:id])
            render json: {message: @message, success: true}
        else
            render json: {success: false, error: [@message.errors]}
        end
    end

    def create
        if current_user.is_admin
            @message = Message.create(message_params)
            @message.user_id = current_user.id
            if @message.save
                render json: {message: @message, success: true}
            else
                render json: {success: false, error: [@message.errors]}
            end
        else
            @message = current_user.conversation.last.messages.create(message_params)
            @message.user_id = current_user.id
            if @message.save
                render json: {message: @message, success: true}
            else
                render json: {success: false, error: [@message.errors]}
            end
        end
    end

    def update
        @message = current_user.message.find(params[:id])
        if @message.update(message_params)
            render json: {message: @message, success: true}
        else
            render json: {success: false, error: [@message.errors]}
        end   
    end

    def destroy
        @message = current_user.message.find(params[:id])
        if @message.destroy
            render json: {message: @message, success: true}
        else
            render json: {success: false, error: [@message.errors]}
        end
    end

    private 
    def message_params
        params.require(:message).permit(:body, :conversation_id)
    end
end
