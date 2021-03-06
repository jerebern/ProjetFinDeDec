class Api::ConversationsController < ApplicationController
    before_action :authenticate_user!
    
    def index 
        if current_user.is_admin
            @emails = Array.new
            @names = Array.new
            if @conversations = Conversation.all.order("created_at")
                @users = User.where(id:[@conversations.all.select(:user_id)])
                if params[:s] == ""
                    render json: {conversations: @conversations, users: @users, success: true}
                elsif params[:q]
                    @querry = Array.new
                    @querry = params[:q].split("^")
                    if @querry[1] == "Name"
                        @users = User.where("MATCH(firstname, lastname) AGAINST(? IN BOOLEAN MODE)", @querry[0] + "*")
                        @conversations = Conversation.where(user_id:[@users.all.select(:id)])
                        render json: {conversations: @conversations, users: @users, success: true}
                    elsif @querry[1] == "Email"
                        #@users = User.where("MATCH(email) AGAINST(? IN BOOLEAN MODE)", + @querry[0] + "*")
                        #*En se fiant à stackoverflow, il semble qu'un fulltext sur une addresse email pose problème. D'où mon utilisation ici d'un LIKE
                        @users = User.where("email LIKE ?", "%" + @querry[0] + "%")
                        @conversations = Conversation.where(user_id:[@users.all.select(:id)])
                        render json: {conversations: @conversations, users: @users, success: true}
                    # elsif @querry[1] == "Date"
                    #     @conversations = Conversation.where("MATCH(created_at) AGAINST(? IN BOOLEAN MODE)" + @querry[0] + "*")
                    #     @users = User.where(id:[@conversations.all.select(:user_id)])
                    #     render json: {conversations: @conversations, users: @users, success: true}
                    elsif @querry[1] == "Titre"
                        @conversations = Conversation.where("MATCH(title) AGAINST(? IN BOOLEAN MODE)", @querry[0] + "*")
                        @users = User.where(id:[@conversations.all.select(:user_id)])
                        render json: {conversations: @conversations, users: @users, success: true}
                    end
                #Sort
                elsif params[:s] == "fullnameUp"
                    @users = User.where(id:[@conversations.all.select(:user_id)]).order(:fullname)
                    @conversations = Conversation.where(user_id:[@users.all.select(:id)])
                    render json: {conversations: @conversations, users: @users, success: true}
                elsif params[:s] == "fullnameDown"
                    @users = User.where(id:[@conversations.all.select(:user_id)]).order(fullname: :desc)
                    @conversations = Conversation.where(user_id:[@users.all.select(:id)])
                    render json: {conversations: @conversations, users: @users, success: true}
                elsif params[:s] == "emailUp"
                    @users = User.where(id:[@conversations.all.select(:user_id)]).order(:email)
                    @conversations = Conversation.where(user_id:[@users.all.select(:id)])
                    render json: {conversations: @conversations, users: @users, success: true}
                elsif params[:s] == "emailDown"
                    @users = User.where(id:[@conversations.all.select(:user_id)]).order(email: :desc)
                    @conversations = Conversation.where(user_id:[@users.all.select(:id)])
                    render json: {conversations: @conversations, users: @users, success: true}
                elsif params[:s] == "creationDateUp"
                    @users = User.where(id:[@conversations.all.select(:user_id)])
                    @conversations = Conversation.where(user_id:[@users.all.select(:id)]).order(:created_at)
                    render json: {conversations: @conversations, users: @users, success: true}
                elsif params[:s] == "creationDateDown"
                    @users = User.where(id:[@conversations.all.select(:user_id)])
                    @conversations = Conversation.where(user_id:[@users.all.select(:id)]).order(created_at: :desc)
                    render json: {conversations: @conversations, users: @users, success: true}
                elsif params[:s] == "titleUp"
                    @users = User.where(id:[@conversations.all.select(:user_id)])
                    @conversations = Conversation.where(user_id:[@users.all.select(:id)]).order(:title)
                    render json: {conversations: @conversations, users: @users, success: true}
                elsif params[:s] == "titleDown"
                    @users = User.where(id:[@conversations.all.select(:user_id)])
                    @conversations = Conversation.where(user_id:[@users.all.select(:id)]).order(title: :desc)
                    render json: {conversations: @conversations, users: @users, success: true}
                end
            else
                render json: {success: false, error: [@conversations.errors]}
            end
        else
            if @conversation = current_user.conversation
                render json: {conversation: @conversation, success: true}
            else
                render json: {success: false, error: [@conversation.errors]}
            end
        end
    end

    def show
        if @conversation = current_user.conversation
            render json: {conversation: @conversation, success: true}
        else
            render json: {success: false, error: [@conversation.errors]}
        end
    end

    def create
        @conversation = current_user.conversation.create(conversation_params)
        @conversation.user_id = current_user.id
        if @conversation.save
            render json: {conversation: @conversation, success: true}
        else
            render json: {success: false, error: [@conversation.errors]}
        end
    end

    def update
        @conversation = current_user.conversation.find(params[:id])
        if @conversation.user_id != current_user.id
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

    def search_params
        params.require(:querry).permit(:q, :t)
    end
end
