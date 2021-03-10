class Api::UserCommandsSummariesController < ApplicationController
    before_action :admin_required
    def index 
        # "Un Switch case c'est pas mal plus sexy qu'un lot de else if " - Jérémy Bernard 05/03/2021 a 3h du matin 
       # Reflexion 5h du matin -> les méthodes les plus inspirantes peuvent être les plus décevantes  
        if params[:q].blank? 
            render json: { user_commands_summary: UserCommandsSummary.find_by_sql("SELECT * FROM user_commands_summary order by total_command_value DESC"), success: true}
        else
            ##va falloir qu'on m'explique comment faire un join sur trois table a la fois par ce que j'en ai aucune idee
            ##On y vas avec ce qui fonctione :(
            render json: { user_commands_summary: UserCommandsSummary.where("email LIKE ?", "%" + params[:q]+ "%"), success: true}
        end
    end
end
