class Api::UserCommandsSummariesController < ApplicationController
    before_action :admin_required
    def index 
        # "Un Switch case c'est pas mal plus sexy qu'une orgie de else if " - Jérémy Bernard 05/03/2021 a 3h du matin 
       # Reflexion 5h du matin -> les méthodes les plus inspirantes peuvent être les plus décevantes  
        if params[:q].blank? and params[:s].blank?
            render json: { user_commands_summary: UserCommandsSummary.find_by_sql("SELECT * FROM user_commands_summary"), success: true}
        ##end
        
        # case params[:s]
        # when "EmailUp"
        #     render json: { user_commands_summary: UserCommandsSummary.sort_by(&email), success: true}
        # when "EmailDown"
        #     render json: { user_commands_summary: UserCommandsSummary.sort_by(&email).reverse, success: true}
        # when "AvgUnitUp" 
        #     render json: { user_commands_summary: UserCommandsSummary.sort_by(&unit_product_value_average), success: true}
        # when "AvgUnitDown" 
        #     render json: { user_commands_summary: UserCommandsSummary.sort_by(&unit_product_value_average).reverse, success: true}
        # when "AvgProductUp" 
        #     render json: { user_commands_summary: UserCommandsSummary.sort_by(&average_unit_per_product), success: true}
        # when "AvgProductDown" 
        #     render json: { user_commands_summary: UserCommandsSummary.sort_by(&average_unit_per_product), success: true}
        # when "MinCommandValueUp" 
        #     render json: { user_commands_summary: UserCommandsSummary.sort_by(&minimum_command_value_sub_total), success: true}
        # when "MinCommandValueDown" 
        #      render json: { user_commands_summary: UserCommandsSummary.sort_by(&minimum_command_value_sub_total).reverse, success: true}
        # when "MaxCommandValueUp" 
        #     render json: { user_commands_summary: UserCommandsSummary.sort_by(&maximum_command_value_sub_total), success: true}
        # when "MaxCommandValueDown" 
        #     render json: { user_commands_summary: UserCommandsSummary.sort_by(&maximum_command_value_sub_total).reverse, success: true}
        # when "AvgCommandValueUp" 
        #     render json: { user_commands_summary: UserCommandsSummary.sort_by(&Average_command_value_sub_total), success: true}
        # when "AvgCommandValueDown" 
        #     render json: { user_commands_summary: UserCommandsSummary.sort_by(&Average_command_value_sub_total).reverse, success: true}
        # when "TotalCommandValueUp" 
        #     render json: { user_commands_summary: UserCommandsSummary.sort_by(&total_command_value), success: true}
        # when "TotalCommandValueDown" 
        #     render json: { user_commands_summary: UserCommandsSummary.sort_by(&total_command_value).reverse, success: true}
        else
            render json: { user_commands_summary: UserCommandsSummary.where("email LIKE ?", "%" + params[:q]+ "%"), success: true}
        end
    end
end
