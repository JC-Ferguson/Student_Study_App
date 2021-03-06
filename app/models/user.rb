class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
      
  has_one :student, dependent: :destroy
  has_one :tutor, dependent: :destroy
  has_many :subject_users, dependent: :destroy
  has_many :subjects, through: :subject_users
  enum classification: {student: 0, tutor: 1 }
  enum education_level: {primary: 0 , highschool: 1, tertiary: 2, special_needs: 3}
  has_one_attached :image, dependent: :destroy
  accepts_nested_attributes_for :subjects
end
