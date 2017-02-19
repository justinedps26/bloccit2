require 'rails_helper'

RSpec.describe Question, type: :model do
  let (:question) { Question.create!(title: "New question", body:"I am the question", resolved: true) }

  describe "attributes" do
    it "has a body attribute" do
      expect(question).to have_attributes(title: "New question", body: "I am the question", resolved: true)
    end
  end
end
