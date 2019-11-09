class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    private
    def after_sign_in_path_for(resource)
        if current_user.student? && current_user.student.looking_for.nil?
            students_path
        elsif current_user.tutor? && current_user.tutor.payment_id.nil?
            tutors_path 
        end
     
    end
    def after_sign_out_path_for(resource_or_scope)
        users_path
    end
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :image, :description, :classification, :education_level, subject_ids: []) }
        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :image, :current_password, :description, :classification, :education_level, subject_ids: []) }
    end
end
