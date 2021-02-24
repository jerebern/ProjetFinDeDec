class Api::ConversationsController < ApplicationController
    def index 
        if @converations = Conversation.all
            render json: @converations
        else
            render json: @converations.errors, status: :unprocessable_entity
        end
    end

    def show
        @user = User.find(params[:user_id])
        if @converation = @user.converations.find(params[:id])
            render json: @converation
        else
            render json: @converation.errors, status: :unprocessable_entity
        end
    end

    def create
        @converation = current_user.converations.new(conversation_params)
        if @converation.save
            render json: @conversation
        else
            render json: @converation.errors, status: :unprocessable_entity
        end
    end

    def update
        @user. User.find(params[:user_id])
        @converation = @user.converations.find(params[:id])
        if @converation.update(conversation_params)
            render json: @converation
        else
            render json: @converation.errors, status: :unprocessable_entity
        end   
    end

    def destroy
        if !is_admin
            redirect_to ''
        else
            @converation = Conversation.find(params[:id])
            if @converation.destroy
                render json: @converation, status: :ok
            else
                render json: @converation.errors, status: :unprocessable_entity
            end
        end
    end

    private 
    def conversation_params
        params.require(:converation).permit(:title, :description, :email_user, :user_id)
    end

    def is_admin
        if current_user.is_admin==true
            return true
        else
            return false
        end
    end
end
