# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.logger = Logger.new(STDOUT)
Post.delete_all
User.delete_all
Category.delete_all

Category.create(id:1,name:"Category 1")
Category.create(id:2,name:"Category 2")
Category.create(id:3,name:"Category 3")

3.times do |i|
   post = Post.new(title:"title 1-#{i}",image:nil,body:"body 1-#{i}",category_id: "1",published: 1)
   post.save
   # ActiveRecord::Base.logger.debug post.errors.inspect
end
2.times do |i|
   Post.create(title:"title 2-#{i}",image:nil,body:"body 2-#{i}",category_id: "2",published: 1)
end
4.times do |i|
   Post.create(title:"title 3-#{i}",image:nil,body:"body 3-#{i}",category_id: "3",published: 1)
end

1.times do |i|
    Tag.create(post_id:Post.first.id,tag:"abc")
    Tag.create(post_id:Post.first.id,tag:"Test")
end

User.create(name:"test_user",
  mail:"test@gmail.com",
  password_digest:"$2a$10$HwjtT6pD2CfVJBioWFJevOuR.m7OeFVbyt2rKk3sni/vB95PNCSJ6",
  remember_token:"6843b3f22969d289e5ad67d456154e8a3ecdc3e305b35f4c717b80bedaa470cd")
