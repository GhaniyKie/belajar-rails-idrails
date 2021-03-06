class ApplicationController < ActionController::Base
    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :pundit_error
    # Before action ini hanya akan dijalankan jika controller yang dimiliki adalah controller devise
    before_action :configure_permitted_parameters, if: :devise_controller?

    private

    def pundit_error
        flash[:notice] = "Gak punya akses lu brader !"
        redirect_to root_path
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
end