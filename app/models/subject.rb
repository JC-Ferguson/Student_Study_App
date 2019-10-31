class Subject < ApplicationRecord
    has_many :subject_users
    has_many :users, through: :subject_users
end