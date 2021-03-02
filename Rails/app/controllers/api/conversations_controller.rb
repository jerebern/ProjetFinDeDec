class Api::ConversationsController < ApplicationController
    before_action :authenticate_user!
    
    def index 
        if is_admin
            if @conversations = Conversation.all
                render json: {conversations: @conversations, success: true}
            else
                render json: {success: false, error: [@conversations.errors]}
            end
        else
            @user = current_user
            if @conversation = @user.conversation
                render json: {conversation: @conversation, success: true}
            else
                render json: {success: false, error: [@conversation.errors]}
            end
        end
    end

    def show
        @user = current_user
        if @conversation = @user.conversation
            render json: {conversation: @conversation, success: true}
        else
            render json: {success: false, error: [@conversation.errors]}
        end
    end

    def create
        @user = current_user
        @conversation = @user.conversation.create(conversation_params)
        @conversation.user_id = @user.id
        if @conversation.save
            render json: {conversation: @conversation, success: true}
        else
            render json: {success: false, error: [@conversation.errors]}
        end
    end

    def update
        @user = current_user
        @conversation = @user.conversation.find(params[:id])
        if @conversation.user_id != @user.id
            redirect_to ''
        else
            if @conversation.update(conversation_params)
                render json: {conversation: @conversation, success: true}
            else
                render json: {success: false, error: [@conversation.errors]}
            end
        end  
    end

    def destroy
        if !is_admin
            redirect_to ''
        else
            @conversation = Conversation.find(params[:id])
            if @conversation.destroy
                render json: {conversation: @conversation, success: true}
            else
                render json: {success: false, error: [@conversation.errors]}
            end
        end
    end

    private 
    def conversation_params
        params.require(:conversation).permit(:title, :description)
    end

    def is_admin
        if current_user.is_admin == true
            return true
        else
            return false
        end
    end
end
