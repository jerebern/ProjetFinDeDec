class Api::ConversationsController < ApplicationController
    def index 
        @user = User.find(params[:user_id])
        if params[:q]
            render json: @user.converations.where("state LIKE ?", "%" + params[:q] + "%")
        else
            if @user = User.find(params[:user_id])
                render json: @user.converations
            else
                render json: @user.errors, status: :unprocessable_entity
            end
        end
    end

    def show
        @user = User.find(params[:user_id])
        if @converation = @user.converations.fin(params[:id])
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
        if current_user.is_admin == false
            redirect_to ''
        else
            @converation = Conversation.find(params[:id])
            if @converation.destroy
                render json: @converation, status: :ok
            else
                render json: @converation.errors, status: :unprocessable_entity
        end
    end

    private 
    def conversation_params
        params.require(:converation).permit(:title, :description)
    end
end
