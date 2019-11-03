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
    end

    def create
    end

    def edit
    end

    def update
    end
end