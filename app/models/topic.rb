class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings


  # Scope is a method that generates methods
  # Its first argument is the name of the method to generate
  # Its second argument provides the logic to run:
        # We use the lambda syntax (-> with a block { ... }) to implement
        # the method's logic
  # the visible_to scope will run the code inside the lambda on the relation
  # or class on which it's called
  # To make it work properly we require an if statement in TopicsController to
  # determine if a user is signed in.
  # lambda block's syntax:
      # This syntax is called the ternary operator:
      # if_this_is_a_true_value ? then_the_result_is_this : else_it_is_this
      # It's like an if statement like:
          # if A then B else C end is the same as a ? b : c
  scope :visible_to, -> (user) { user ? all : where(public: true) }
  # It now returns the equivalent of Topic.all or Topic.where(public: true)
  # depending on the value of user (present or nil)


end
