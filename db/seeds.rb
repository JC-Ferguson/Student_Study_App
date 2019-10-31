# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

for i in 1..10
    user=User.new
    user.email="test#{i}@example.com"
    user.name="Jurra#{i}.0"
    user.description="Just a lad who needs a lot of help"
    user.password="testing"
    user.password_confirmation="testing"
    user.save
    puts "user #{i} created"
    if i.even?
        Student.create(school:"Coder Academy", user_id: i)
        puts "User #{i} is a student"
    else
        Tutor.create(price: 2500, user_id: i)
        puts "User#{i} is a tutor"
    end
end
