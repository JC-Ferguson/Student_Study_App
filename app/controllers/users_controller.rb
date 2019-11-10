class UsersController < ApplicationController
    # before actions run methods before specified methods in square brackets
    before_action :translate_params, only: [:create_tutor, :update_tutor]
    before_action :set_user, only: [:show]
    before_action :authenticate_user!, except: [:index]
    before_action :set_tutor, only: [:edit_tutor, :update_tutor]
    before_action :set_student, only: [:edit_student, :update_student]


    def index
        @search=params[:search]
        sort=params[:sort]
        common_users=[]
        # conditional sets the user information that will be returned to the index page based on the current user state
        # code calls user model and based on the current user parameters returns only the information relevent to them based 
        # on whether user is at the same education level to them and whether the user is the corect classification current user is
        # searching for(student or tutor), failing that if user not signed in returns full database of users for viewing.

        if user_signed_in? == false
            if sort=="student" || sort=="tutor"                                                     
                users=User.where(classification: sort)
            else
                users=User.all
            end
            users.each do |user|
                if user.tutor? && user.tutor.payment_id==nil
                    next
                else
                    common_users.push(user) 
                end
            end
            
            if @search && @search!=""
                query=[]
                    common_users.each do |peep| 
                        peep.subjects.each do |s| 
                            if s[:name]==@search.capitalize
                                query.push(peep)
                                break
                            end
                        end
                       
                    end
                    return @users=query
            else
                return @users=common_users
            end                                                              #if user isnt't signed in returns all users exiting method
        elsif current_user.student? && current_user.student.looking_for=="study_group"
            users=User.where(classification: 0, education_level: current_user.education_level)
        elsif current_user.student? && current_user.student.looking_for=="both"
            if sort=="student" || sort=="tutor"                                                     
                users=User.where(classification: sort, education_level: current_user.education_level)
            else
                users=User.where(education_level: current_user.education_level)
            end
        elsif current_user.tutor?
            users=User.where(classification: 0, education_level: current_user.education_level)
        elsif current_user.student? && current_user.student.looking_for=="tutors"
            users=User.where(classification: 1, education_level: current_user.education_level)
        end
        
        # once correct user parameters are returned loop is used to filter through returned users and keep
        # users that have matching subjects with current user
        current_user_subjects=current_user.subjects
        users.each do |user|
            if user.tutor? && user.tutor.payment_id.nil?                                            # conditional that skips tutors that have not had payment verified so they're not displayed to users
                next
            end
            user_subjects=user.subjects
            for courses in user_subjects
                if common_users.include?(user)
                    break
                end
                current_user_subjects.each do |my_course|
                    if courses[:name]==my_course[:name] && user.id!=current_user.id
                        common_users.push(user) 
                        break
                    end
                end
            end
        end
        if @search && @search!=""
            query=[]
                common_users.each do |peep| 
                    peep.subjects.each do |s| 
                        if s[:name]==@search.capitalize
                            query.push(peep)
                            break
                        end
                    end
                    
                end
                return @users=query
        else
            return @users=common_users
        end   
    end

    def show
        # conditional that allows access to availability times only for the associated tutor and only run if the user is a tutor
        if @user.tutor?
            @tutor_times=AvailabilityTutor.where(tutor_id:@user.tutor.id)                           
        end
    end

    def new_student 
        # new student generator associated to form that follows user creation if student path was chosen
        @student=Student.new
    end

    def create_student

        # creation of the actual student posts all the relevant data the the newly generated student
        # conditional states if the user successfully creates the student taken to the homepage otherwise 
        # student form is regenerated to input details again
        if current_user.create_student(whitelisted_student_params)
            redirect_to root_path                                                                   
        else
            redirect_to students_path
        end
    end

    def new_tutor
        # new tutor generated with no values that follows user creation if tutor path was chosen
        # tutors have availabilities through the join table accessable to them making availabilities required 
        @tutor=Tutor.new 
        @availabilities=Availability.all
    end

    def create_tutor 

        # creation of the tutor that posts all the users inputted data to the tutor same as student creation
        # conditional states if the user creates the tutor with no errors they are redirected to the payment page
        # used for tutor verification otherwise tutor form is regenerated
        if current_user.create_tutor(tutor_params)
            session = Stripe::Checkout::Session.create(
                    payment_method_types: ['card'],
                    line_items: [{
                        name: current_user.name,
                        amount: 500,
                        currency: 'aud',
                        quantity: 1,
                    }],
                    payment_intent_data: {
                        metadata: {
                            user_id: current_user.id
                        }
                    },

                    # redirects based on where the user will be sent based on success or cancellation of payment
                    success_url: root_url + "payments/success",
                    cancel_url: root_url + "users_connect/new_tutor",
                )

                # session id is stored as instance variable so it can be referenced on the stripe payment page view
                @session_id=session.id
        else
            redirect_to tutors_path
        end
    end

    def edit_student
    end

    def update_student
        # method updates student details same parameters as create but changing the pre existing data rather than creating it
        # conditional redirects to users updated path if successfull otherwise the edit form once again.
        if @student.update(student_params)
            redirect_to user_profile_path(current_user.id)
        else
            redirect_to edit_student_path
        end
    end 

    def edit_tutor
        # once again the tutor requires access to the availabilities that are open to it if the user were to update their availabilities
        @availabilities=Availability.all
    end

    def update_tutor
        # method updates the tutor details the same way as update student method does the conditional redirects according to success or failure
        # of the update
        if @tutor.update(tutor_params)
            redirect_to user_profile_path(current_user.id)
        else
            redirect_to edit_tutor_path
        end
    end

    private
    def user_params
        # sets the allowed parameters for the user information required for the create and update forms 
        params.require(:user).permit(:name, :description, :classification, :education_level, :image, subject_ids: [])
    end

    def tutor_params
        # sets the allowed parameters for the tutor information required for the create and update forms 
        params.require(:tutor).permit(:price, :user_id, :qualifications, availability_ids: []) # :availability_tutors_start_time, :availability_tutors_end_time, availability_ids: [] )
    end

    def student_params
        # sets the allowed parameters for the student information required for the create and update forms 
        params.require(:student).permit(:school, :looking_for, :user_id )
    end

    def translate_params
        # allows user to input given price as dollars and translates back to cents for the controller (see before actions)
        params[:tutor][:price] = (params[:tutor][:price].to_f * 100).to_i
    end

    def set_user
        # finds the associated user for the required page (see before actions)
        @user=User.find(params[:id]) 
    end

    def set_tutor
        # finds the associated tutor for the required forms create and update (see before actions)
        @tutor=current_user.tutor
    end

    def set_student
        # finds the associated student for the required forms create and update (see before actions)
        @student=current_user.student
    end
end