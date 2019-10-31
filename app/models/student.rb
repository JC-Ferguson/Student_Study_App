class Student < ApplicationRecord
    belongs_to :user
    enum looking_for: {tutors: 0, study_group: 1, both: 2}
end