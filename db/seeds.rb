require 'random_data'

# Create topics
15.times do
  Topic.create!(
    name: RandomData.random_sentence,
    description: RandomData.random_paragraph
  )
end

topics = Topic.all

# Create posts
50.times do
  Post.create!(
  topic: topics.sample,
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
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
