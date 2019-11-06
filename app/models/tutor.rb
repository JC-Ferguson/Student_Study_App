class Tutor < ApplicationRecord
    belongs_to :user
    has_many :availability_tutors
    has_many :availabilities, through: :availability_tutors 
end