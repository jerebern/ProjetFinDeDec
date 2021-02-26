class Api::ConversationsController < ApplicationController
    def index 
        if is_admin
            if @conversations = Conversation.all
                render json: @conversations
            else
                render json: @conversations.errors, status: :unprocessable_entity
            end
        end
    end

    def show
        @user = current_user
        if @conversation = @user.conversation
            render json: @conversation
        else
            render json: @conversation.errors, status: :unprocessable_entity
        end
    end

    def create
        @user = current_user
        @conversation = @user.conversation.create(conversation_params)
        if @conversation.save
            render json: @conversation
        else
            render json: @conversation.errors, status: :unprocessable_entity
        end
    end

    def update
        @user. User.find(params[:user_id])
        @conversation = @user.conversation.find(params[:id])
        if @conversation.update(conversation_params)
            render json: @conversation
        else
            render json: @conversation.errors, status: :unprocessable_entity
        end   
    end

    def destroy
        if !is_admin
            redirect_to ''
        else
            @conversation = Conversation.find(params[:id])
            if @conversation.destroy
                render json: @conversation, status: :ok
            else
                render json: @conversation.errors, status: :unprocessable_entity
            end
        end
    end

    private 
    def conversation_params
        params.require(:conversation).permit(:title, :description, :email_user, :user_id)
    end

    def is_admin
        if current_user.is_admin==true
            return true
        else
            return false
        end
    end
end
