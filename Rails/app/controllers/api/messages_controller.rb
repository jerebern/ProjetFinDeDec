class Api::MessagesController < ApplicationController
    before_action :authenticate_user!
    
    def index 
        if is_admin
            if @messages = Message.all
                render json: {messages: @messages, success: true}
            else
                render json: {success: false, error: [@messages.errors]}
            end
        else
            @user = current_user
            if @messages = @user.conversation.last.messages
                render json: {messages: @messages, success: true}
            else
                render json: {success: false, error: [@messages.errors]}
            end
        end
    end

    def show
        @user = current_user
        if @message = @user.message.find(params[:id])
            render json: {message: @message, success: true}
        else
            render json: {success: false, error: [@message.errors]}
        end
    end

    def create
        if is_admin
            @message = Message.create(message_params)
            @message.user_id = current_user.id
            if @message.save
                render json: {message: @message, success: true}
            else
                render json: {success: false, error: [@message.errors]}
            end
        else
            @user = current_user
            @message = @user.conversation.last.messages.create(message_params)
            @message.user_id = @user.id
            if @message.save
                render json: {message: @message, success: true}
            else
                render json: {success: false, error: [@message.errors]}
            end
        end
    end

    def update
        @user = current_user
        @message = @user.message.find(params[:id])
        if @message.update(message_params)
            render json: {message: @message, success: true}
        else
            render json: {success: false, error: [@message.errors]}
        end   
    end

    def destroy
        @user = current_user
        @message = @user.message.find(params[:id])
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

    def is_admin
        if current_user.is_admin==true
            return true
        else
            return false
        end
    end
end
