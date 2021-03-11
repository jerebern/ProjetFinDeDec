class Api::UserConversationMessagesSummariesController < ApplicationController
    before_action :admin_required
    
    def index
        if params[:s] == ""
            render json: { user_conversation_messages_summary: UserConversationMessagesSummary.find_by_sql("SELECT * FROM user_conversation_messages_summary order by fullname ASC"), success: true}
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
        end
    end
end
