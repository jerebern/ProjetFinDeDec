class Api::MessagesController < ApplicationController
    def index 
        if is_admin
            @user = current_user
            if @messages = Message.all
                render json: @messages
            else
                render json: @messages.errors, status: :unprocessable_entity
            end
        else
            @user = current_user
            if @messages = @user.conversation.last.messages
                render json: @messages
            else
                render json: @messages.errors, status: :unprocessable_entity
            end
        end
    end

    def show
        @user = current_user
        if @message = @user.message.find(params[:id])
            render json: @message
        else
            render json: @message.errors, status: :unprocessable_entity
        end
    end

    def create
        if is_admin
            @message = Message.create(message_params)
            if @message.save
                render json: @message
            else
                render json: @message.errors, status: :unprocessable_entity
            end
        else
            @user = current_user
            @message = @user.conversation.last.messages.create(message_params)
            if @message.save
                render json: @message
            else
                render json: @message.errors, status: :unprocessable_entity
            end
        end
    end

    def update
        @user. current_user
        @message = @user.conversation.messages.find(params[:id])
        if @message.update(message_params)
            render json: @message
        else
            render json: @message.errors, status: :unprocessable_entity
        end   
    end

    #à modifier
    def destroy
        if !is_admin
            redirect_to ''
        else
            @message = Message.find(params[:id])
            if @message.destroy
                render json: @message, status: :ok
            else
                render json: @message.errors, status: :unprocessable_entity
            end
        end
    end

    private 
    def message_params
        params.require(:message).permit(:texte, :conversation_id, :user_id)
    end

    def is_admin
        if current_user.is_admin==true
            return true
        else
            return false
        end
    end
end
