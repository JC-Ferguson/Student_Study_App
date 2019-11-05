class ApplicationController < ActionController::Base
    private
    def after_sign_in_path_for(resource)
        if current_user.education_level.nil?
            new_user_path
        else
            root_path
        end
    end
    def after_sign_out_path_for(resource_or_scope)
        new_user_session_path
      end
end
