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

availabilities_arr= [  
                        "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
]

subjects_arr.each do |subject|
    Subject.create(name: "#{subject}")
    puts "#{subject} subject generated."
end

availabilities_arr.each do |day|
    Availability.create(day: "#{day}")
    puts "#{day} generated"
end


for i in 1..60
    user=User.new
    user.email= Faker::Internet.unique.email
    user.name=Faker::Name.name 
    user.description=Faker::Lorem.paragraph
    user.password="testing"
    user.password_confirmation="testing"
    if i <=40
        user.classification= 0
    else
        user.classification=1
    end
    if i.between?(1,10) || i.between?(41,45)
        user.education_level= 0
    elsif i.between?(11,20) || i.between?(46,50)
        user.education_level=1
    elsif i.between?(21,30) || i.between?(51,55)
        user.education_level=2
    elsif i.between?(31,40) || i.between?(56,60)
        user.education_level=3
    end  
    # user.image.attach(io: File.open("app/assets/images/home/students_pic.jpg") ,filename: "students_pic.jpg")
    user.save
    puts "user #{i} created as #{user.classification}"


    if user.student?
        Student.create(school: Faker::University.name, user_id: i, looking_for: rand(0..2))
        puts "Student details updated"
    else
        Tutor.create(price: rand(2000..8000), user_id: i)
        puts "Tutor Details updated"
        for i in 1..rand(1..3)
            availability=Availability.find(rand(1..7))
            availability.update(start_time:"rand(8..14):00:00", end_time:"rand(15..20):00:00")
            AvailabilityTutor.create(tutor_id:user.tutor.id, availability_id:availability.id)
            puts "Tutor #{user.tutor.id} created with availability on #{availability.day} at #{availability.start_time} until #{availability.end_time}"
        end
    end

    SubjectUser.create(subject_id: 17, user_id: i)
    SubjectUser.create(subject_id: 20, user_id: i)
    SubjectUser.create(subject_id: 21, user_id: i)
    SubjectUser.create(subject_id: rand(1..8), user_id: i)
    SubjectUser.create(subject_id: rand(8..16), user_id: i)
end