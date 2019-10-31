# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
subjects_arr=[  "Chemistry", "Physics", "Biology", "History", "Geography", "Commerce", "Dance", "Drama", "Music", "Visual Arts",
                "Chinese", "French", "German", "Indonesian", "Italian", "Japanese", "IT", "Design Technology", "Home Economics", 
                "English", "Maths", "PD/H/PE" ]

subjects_arr.each do |subject|
    Subject.create(name: "#{subject}")
    puts "#{subject} subject generated."
end


for i in 1..10
    user=User.new
    user.email="test#{i}@example.com"
    user.name="Jurra#{i}.0"
    user.description="Just a lad who needs a lot of help"
    user.password="testing"
    user.password_confirmation="testing"
    user.classification=rand(0..1)
    user.education_level=rand(0..3)
    user.save
    puts "user #{i} created as #{user.classification}"


    if user.student?
        Student.create(school:"Coder Academy", user_id: i, looking_for: rand(0..2))
        puts "Student details updated"
    else
        Tutor.create(price: rand(2000..8000), user_id: i)
        puts "Tutor Details updated"
    end

    SubjectUser.create(subject_id: 17, user_id: i)
    SubjectUser.create(subject_id: 20, user_id: i)
    SubjectUser.create(subject_id: 21, user_id: i)
    SubjectUser.create(subject_id: rand(1..8), user_id: i)
    SubjectUser.create(subject_id: rand(8..16), user_id: i)
end
