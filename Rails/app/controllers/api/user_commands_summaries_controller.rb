class Api::UserCommandsSummariesController < ApplicationController
    before_action :admin_required
    def index 
        
        if params[:q].blank?
            render json: { user_commands_summary: UserCommandsSummary.find_by_sql("SELECT * FROM user_commands_summary"), success: true}
        else
            render json: { user_commands_summary: UserCommandsSummary.where("email LIKE ?", "%" + params[:q]+ "%"), success: true}
        end
    end
end
