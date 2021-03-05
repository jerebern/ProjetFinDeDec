class Api::ConversationsController < ApplicationController
    before_action :authenticate_user!
    
    def index 
        if is_admin
            @users = User.all
            @emails = Array.new
            @names = Array.new
            if @conversations = Conversation.all
                @conversations.each do |c|
                    @users.each do |u|
                        if c.user_id == u.id
                            @emails.push(u.email)
                            @names.push(u.fullname)
                        end
                    end
                end
                if params[:s] == ""
                    render json: {conversations: @conversations, emails: @emails, names: @names, success: true}
                elsif params[:q]
                    @querry = Array.new
                    @querry = params[:q].split("@")
                    if @querry[1] == "Name"
                        @emails = Array.new
                        @names = Array.new
                        @users = User.where("fullname LIKE ?", "%" + @querry[0] + "%")
                        @conversations = Conversation.where(user_id:[@users.all.select(:id)])
                        @conversations.each do |c|
                            @users.each do |u|
                                if c.user_id == u.id
                                    @emails.push(u.email)
                                    @names.push(u.fullname)
                                end
                            end
                        end
                        render json: {conversations: @conversations, emails: @emails, names: @names, success: true}
                    elsif @querry[1] == "Email"
                        @emails = Array.new
                        @names = Array.new
                        @users = User.where("email LIKE ?", "%" + @querry[0] + "%")
                        @conversations = Conversation.where(user_id:[@users.all.select(:id)])
                        @conversations.each do |c|
                            @users.each do |u|
                                if c.user_id == u.id
                                    @emails.push(u.email)
                                    @names.push(u.fullname)
                                end
                            end
                        end
                        render json: {conversations: @conversations, emails: @emails, names: @names, success: true}
                    elsif @querry[1] == "Date"
                        @emails = Array.new
                        @names = Array.new
                        @conversations = Conversation.where("created_at LIKE ?", "%" + @querry[0] + "%")
                        @users = User.where(id:[@conversations.all.select(:user_id)])
                        @conversations.each do |c|
                            @users.each do |u|
                                if c.user_id == u.id
                                    @emails.push(u.email)
                                    @names.push(u.fullname)
                                end
                            end
                        end
                        render json: {conversations: @conversations, emails: @emails, names: @names, success: true}
                    elsif @querry[1] == "Titre"
                        @emails = Array.new
                        @names = Array.new
                        @conversations = Conversation.where("title LIKE ?", "%" + @querry[0] + "%")
                        @users = User.where(id:[@conversations.all.select(:user_id)])
                        @conversations.each do |c|
                            @users.each do |u|
                                if c.user_id == u.id
                                    @emails.push(u.email)
                                    @names.push(u.fullname)
                                end
                            end
                        end
                        render json: {conversations: @conversations, emails: @emails, names: @names, success: true}
                    end
                elsif params[:s] == "fullnameUp"
                    @users = User.all
                    @names = @names.sort
                    @emails = Array.new
                    @conversationsTemp = Array.new
                    @names.each do |n|
                        @users.each do |u|
                            @tempfullname = u.fullname 
                            if @tempfullname == n
                                @conversations.each do |c| 
                                    if u.id == c.user_id
                                        @conversationsTemp.push(c)
                                        @emails.push(u.email)
                                    end
                                end
                            end
                        end
                    end
                    render json: {conversations: @conversationsTemp, emails: @emails, names: @names, success: true}
                elsif params[:s] == "fullnameDown"
                    @users = User.all
                    @names = @names.sort{ |a, b| b <=> a }
                    @emails = Array.new
                    @conversationsTemp = Array.new
                    @names.each do |n|
                        @users.each do |u|
                            @tempfullname = u.fullname
                            if @tempfullname == n
                                @conversations.each do |c| 
                                    if u.id == c.user_id
                                        @conversationsTemp.push(c)
                                        @emails.push(u.email)
                                    end
                                end
                            end
                        end
                    end
                    render json: {conversations: @conversationsTemp, emails: @emails, names: @names, success: true}
                elsif params[:s] == "emailUp"
                    @users = User.all
                    @emails = @emails.sort
                    @names = Array.new
                    @conversationsTemp = Array.new
                    @emails.each do |e| 
                        @users.each do |u|
                            @emailsTemp = u.email
                            if @emailsTemp == e
                                @conversations.each do |c|
                                    if u.id == c.user_id
                                        @conversationsTemp.push(c)
                                        @names.push(u.fullname)    
                                    end
                                end
                            end
                        end
                    end
                    render json: {conversations: @conversationsTemp, emails: @emails, names: @names, success: true}
                elsif params[:s] == "emailDown"
                    @users = User.all
                    @emails = @emails.sort{ |a, b| b <=> a }
                    @names = Array.new
                    @conversationsTemp = Array.new
                    @emails.each do |e| 
                        @users.each do |u|
                            @emailsTemp = u.email
                            if @emailsTemp == e
                                @conversations.each do |c|
                                    if u.id == c.user_id
                                        @conversationsTemp.push(c)
                                        @names.push(u.fullname)    
                                    end
                                end
                            end
                        end
                    end
                    render json: {conversations: @conversationsTemp, emails: @emails, names: @names, success: true}
                elsif params[:s] == "creationDateUp"
                    @conversations = @conversations.sort_by(&:created_at)
                    @users = User.all
                    @names = Array.new
                    @emails = Array.new
                    @conversations.each do |c|
                        @users.each do |u|
                            if c.user_id == u.id
                                @names.push(u.fullname)
                                @emails.push(u.email)
                            end
                        end
                    end
                    render json: {conversations: @conversations, emails: @emails, names: @names, success: true}
                elsif params[:s] == "creationDateDown"
                    @conversations = @conversations.sort_by(&:created_at).reverse
                    @users = User.all
                    @names = Array.new
                    @emails = Array.new
                    @conversations.each do |c|
                        @users.each do |u|
                            if c.user_id == u.id
                                @names.push(u.fullname)
                                @emails.push(u.email)
                            end
                        end
                    end
                    render json: {conversations: @conversations, emails: @emails, names: @names, success: true}
                elsif params[:s] == "titleUp"
                    @conversations = @conversations.sort_by(&:title)
                    @users = User.all
                    @names = Array.new
                    @emails = Array.new
                    @conversations.each do |c|
                        @users.each do |u|
                            if c.user_id == u.id
                                @names.push(u.fullname)
                                @emails.push(u.email)
                            end
                        end
                    end
                    render json: {conversations: @conversations, emails: @emails, names: @names, success: true}
                elsif params[:s] == "titleDown"
                    @conversations = @conversations.sort_by(&:title).reverse
                    @users = User.all
                    @names = Array.new
                    @emails = Array.new
                    @conversations.each do |c|
                        @users.each do |u|
                            if c.user_id == u.id
                                @names.push(u.fullname)
                                @emails.push(u.email)
                            end
                        end
                    end
                    render json: {conversations: @conversations, emails: @emails, names: @names, success: true}
                end 
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
        #else
            #à continuer
         #   render json: {conversations: Conversation.where("MATCH(body) AGAINST(?)", params[:q].as_json(success: true))}
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

    def search_params
        params.require(:querry).permit(:q, :t)
    end

    def is_admin
        if current_user.is_admin == true
            return true
        else
            return false
        end
    end
end
