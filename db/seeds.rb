# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
5.times do |i|
   Post.create(title:"title #{i}",body:"body #{i}")
end

User.create(name:"test_user",
  mail:"test@gmail.com",
  password_digest:"$2a$10$HwjtT6pD2CfVJBioWFJevOuR.m7OeFVbyt2rKk3sni/vB95PNCSJ6",
  remember_token:"6843b3f22969d289e5ad67d456154e8a3ecdc3e305b35f4c717b80bedaa470cd")

Category.create(name:"CategoryA")
Category.create(name:"CategoryB")
Category.create(name:"CategoryC")
