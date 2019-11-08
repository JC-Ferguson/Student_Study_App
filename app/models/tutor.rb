class Tutor < ApplicationRecord
    belongs_to :user
    has_many :availability_tutors, dependent: :destroy
    has_many :availabilities, through: :availability_tutors 
    has_one_attached :qualifications, dependent: :destroy
end