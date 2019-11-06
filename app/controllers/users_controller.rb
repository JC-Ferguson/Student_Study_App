class UsersController < ApplicationController
    before_action :authenticate_user!


    def index
        if current_user.student? && current_user.student.looking_for=="tutors"
            users=User.where(classification: 1, education_level: current_user.education_level)
        elsif current_user.student? && current_user.student.looking_for=="study_group"
            users=User.where(classification: 0, education_level: current_user.education_level)
        elsif current_user.student? && current_user.student.looking_for=="both"
            users=User.where(education_level: current_user.education_level)
        elsif current_user.tutor?
            users=User.where(classification: 0, education_level: current_user.education_level)
        end
        common_users=[]
        current_user_subjects=current_user.subjects
        users.each do |user|
            user_subjects=user.subjects
            for courses in user_subjects
                if common_users.include?(user)
                    break
                end
                current_user_subjects.each do |my_course|
                    if courses[:name]==my_course[:name] && common_users.include?(user)==false
                        common_users.push(user)
                        break
                    end
                end
            end
        end
        @users=common_users
    end

    def show
    
        @user=User.find(params[:id]) 
    end

    def new
        @user=User.new
        @subjects=Subject.all
        
    end

    def create
        whitelisted_user_params=user_params
        
        if current_user.update(whitelisted_user_params) && current_user.student?
            redirect_to students_path
         
        elsif current_user.update(whitelisted_user_params) && current_user.tutor?
            redirect_to tutors_path
        else 
            redirect_to new_user_path
        end

        
    end

    def new_student 
        @student=Student.new
    end

    def create_student
        whitelisted_student_params=student_params
        if current_user.create_student(whitelisted_student_params)
            redirect_to root_path
        else
            redirect_to students_path
        end
    end

    def new_tutor
        @tutor=Tutor.new 
    end

    def create_tutor 
        whitelisted_tutor_params=tutor_params
        if current_user.create_tutor(whitelisted_tutor_params)
            session = Stripe::Checkout::Session.create(
                payment_method_types: ['card'],
                line_items: [{
                    name: current_user.name,
                    amount: 500,
                    currency: 'aud',
                    quantity: 1,
                }],
                success_url: root_url + "payment/success",
                cancel_url: root_url + "users_connect/new_tutor",
                )
                @session_id=session.id
        else
            redirect_to tutors_path
        end
    end

    def edit
    end

    def update
    end 

    private
    def user_params
        params.require(:user).permit(:name, :description, :classification, :education_level, :image, subject_ids: [])
    end
    def tutor_params
        params.require(:tutor).permit(:price, :user_id)
    end
    def student_params
        params.require(:student).permit(:school, :looking_for, :user_id )
    end
end