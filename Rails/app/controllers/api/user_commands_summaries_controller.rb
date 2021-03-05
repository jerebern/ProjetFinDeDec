class Api::UserCommandsSummariesController < ApplicationController
    before_action :admin_required
    def index 
        render json: { user_commands_summary: UserCommandsSummary.find_by_sql("SELECT * FROM user_commands_summary"), success: true}
    end
end
