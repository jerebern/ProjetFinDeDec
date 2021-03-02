class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :show_errors_404

    def show_errors_404
        render json: { success: false, error: "erreur 404 page introuvable" }, status: 200
    end

    def admin_required
        if !current_user || !current_user.is_admin
            render json: { success: false, error: "not admin" }
        end
    end
end
