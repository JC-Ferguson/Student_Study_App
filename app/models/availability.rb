class Availability < ApplicationRecord
    has_many :availability_tutors
    has_many :tutors, through: :availability_tutors 
end