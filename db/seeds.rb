require 'random_data'

# Create posts
50.times do
  Post.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end

# Create a unique post
1.times do
  Post.create!(
    title: "I am the test post",
    body: "I am the body of the test post"
  )
end

posts = Post.all

# Create comments
100.times do
  Comment.create!(
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

# Create a unique comment
1.times do
  Comment.create!(
    body: "I am the unique comment of the unique test post"
  )
end

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
