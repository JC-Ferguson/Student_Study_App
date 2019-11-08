class PagesController < ApplicationController
    before_action :tutor_payment_check, only: [:home]
    def home
        @current=current_user
    end

    private
    def tutor_payment_check
        if user_signed_in? && current_user.tutor? && current_user.tutor.payment_id.nil?
            redirect_to tutors_path
        end
    end
end