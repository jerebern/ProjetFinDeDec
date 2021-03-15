class Api::UserConversationMessagesSummariesController < ApplicationController
    before_action :admin_required
    
    def index
        if params[:s] == ""
            render json: { user_conversation_messages_summary: UserConversationMessagesSummary.find_by_sql("SELECT * FROM user_conversation_messages_summary order by number_days_resolution ASC, number_messages DESC"), success: true}
        elsif params[:s] == "fullnameUp"
            render json: { user_conversation_messages_summary: UserConversationMessagesSummary.find_by_sql("SELECT * FROM user_conversation_messages_summary order by fullname ASC"), success: true}   
        elsif params[:s] == "fullnameDown"
            render json: { user_conversation_messages_summary: UserConversationMessagesSummary.find_by_sql("SELECT * FROM user_conversation_messages_summary order by fullname DESC"), success: true}
        elsif params[:s] == "emailUp"
            render json: { user_conversation_messages_summary: UserConversationMessagesSummary.find_by_sql("SELECT * FROM user_conversation_messages_summary order by email ASC"), success: true}
        elsif params[:s] == "emailDown"
            render json: { user_conversation_messages_summary: UserConversationMessagesSummary.find_by_sql("SELECT * FROM user_conversation_messages_summary order by email DESC"), success: true}
        elsif params[:s] == "titleUp"
            render json: { user_conversation_messages_summary: UserConversationMessagesSummary.find_by_sql("SELECT * FROM user_conversation_messages_summary order by title ASC"), success: true}
        elsif params[:s] == "titleDown"    
            render json: { user_conversation_messages_summary: UserConversationMessagesSummary.find_by_sql("SELECT * FROM user_conversation_messages_summary order by title DESC"), success: true}
        elsif params[:s] == "nbrMessagesUp"    
            render json: { user_conversation_messages_summary: UserConversationMessagesSummary.find_by_sql("SELECT * FROM user_conversation_messages_summary order by number_messages ASC"), success: true}
        elsif params[:s] == "nbrMessagesDown"    
            render json: { user_conversation_messages_summary: UserConversationMessagesSummary.find_by_sql("SELECT * FROM user_conversation_messages_summary order by number_messages DESC"), success: true}
        elsif params[:s] == "lgMessagesUp"    
            render json: { user_conversation_messages_summary: UserConversationMessagesSummary.find_by_sql("SELECT * FROM user_conversation_messages_summary order by length_messages ASC"), success: true}
        elsif params[:s] == "lgMessagesDown"    
            render json: { user_conversation_messages_summary: UserConversationMessagesSummary.find_by_sql("SELECT * FROM user_conversation_messages_summary order by length_messages DESC"), success: true}
        elsif params[:s] == "avgMessagesUp"    
            render json: { user_conversation_messages_summary: UserConversationMessagesSummary.find_by_sql("SELECT * FROM user_conversation_messages_summary order by avg_length_messages ASC"), success: true}
        elsif params[:s] == "avgMessagesDown"    
            render json: { user_conversation_messages_summary: UserConversationMessagesSummary.find_by_sql("SELECT * FROM user_conversation_messages_summary order by avg_length_messages DESC"), success: true}
        elsif params[:s] == "creationDateUp"    
            render json: { user_conversation_messages_summary: UserConversationMessagesSummary.find_by_sql("SELECT * FROM user_conversation_messages_summary order by conversation_created_at ASC"), success: true}
        elsif params[:s] == "creationDateDown"    
            render json: { user_conversation_messages_summary: UserConversationMessagesSummary.find_by_sql("SELECT * FROM user_conversation_messages_summary order by conversation_created_at DESC"), success: true}
        elsif params[:s] == "resolutionUp"    
            render json: { user_conversation_messages_summary: UserConversationMessagesSummary.find_by_sql("SELECT * FROM user_conversation_messages_summary order by number_days_resolution ASC"), success: true}
        elsif params[:s] == "resolutionDown"    
            render json: { user_conversation_messages_summary: UserConversationMessagesSummary.find_by_sql("SELECT * FROM user_conversation_messages_summary order by number_days_resolution DESC"), success: true}
        elsif params[:s] == "statusUp"
            render json: { user_conversation_messages_summary: UserConversationMessagesSummary.find_by_sql("SECLECT * FROM user_conversation_messages_summary order by status ASC"), success: true}
        elsif params[:s] == "statusDown"
            render json: { user_conversation_messages_summary: UserConversationMessagesSummary.find_by_sql("SECLECT * FROM user_conversation_messages_summary order by status DESC"), success: true}
        elsif params[:q]
            @querry = Array.new
            @querry = params[:q].split("(*)")
            if @querry[0] == "Nom"
                @summary = UserConversationMessagesSummary.joins("JOIN users ON user_conversation_messages_summary.email = users.email").where("MATCH(firstname, lastname) AGAINST(? IN BOOLEAN MODE)", @querry[1]);
                if @querry[2] == "Tout"
                    render json: { user_conversation_messages_summary: @summary, success: true}
                elsif @querry[2] == "En cours"
                    render json: { user_conversation_messages_summary: @summary.where(status: "En cours"), success: true}
                elsif @querry[2 == "Terminer"]
                    render json: { user_conversation_messages_summary: @summary.where(status: "Terminer"), success: true}
                end
            elsif @querry[0] == "Email"
                @summary = UserConversationMessagesSummary.joins("JOIN users ON user_conversation_messages_summary.email = users.email").where("users.email LIKE ?","%" +  @querry[1] + "%");
                if @querry[2] == "Tout"
                    render json: { user_conversation_messages_summary: @summary, success: true}
                elsif @querry[2] == "En cours"
                    render json: { user_conversation_messages_summary: @summary.where(status: "En cours"), success: true}
                elsif @querry[2] == "Terminer"
                    render json: { user_conversation_messages_summary: @summary.where(status: "Terminer"), success: true}
                end
            elsif @querry[0] == "Titre"
                @summary = UserConversationMessagesSummary.joins("JOIN conversations ON user_conversation_messages_summary.title = conversations.title").where("MATCH(conversations.title) AGAINST(? IN BOOLEAN MODE)", @querry[1]);
                if @querry[2] == "Tout"
                    render json: { user_conversation_messages_summary: @summary, success: true}
                elsif @querry[2] == "En cours"
                    render json: { user_conversation_messages_summary: @summary.where(status: "En cours"), success: true}
                elsif @querry[2] == "Terminer"
                    render json: { user_conversation_messages_summary: @summary.where(status: "Terminer"), success: true}
                end
            end
        elsif params[:f] == "Tout"
            render json: { user_conversation_messages_summary: UserConversationMessagesSummary.find_by_sql("SELECT * FROM user_conversation_messages_summary order by number_days_resolution ASC, number_messages DESC"), success: true}
        elsif params[:f] == "En cours"
            render json: { user_conversation_messages_summary: UserConversationMessagesSummary.find_by_sql("SELECT * FROM user_conversation_messages_summary where status = 'En cours' order by number_days_resolution ASC, number_messages DESC"), success: true}
        elsif params[:f] == "Terminer"
            render json: { user_conversation_messages_summary: UserConversationMessagesSummary.find_by_sql("SELECT * FROM user_conversation_messages_summary where status = 'Terminer' order by number_days_resolution ASC, number_messages DESC"), success: true}
        end
    end
end
