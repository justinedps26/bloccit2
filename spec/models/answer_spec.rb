require 'rails_helper'

RSpec.describe Answer, type: :model do
  let (:question) { Question.create!(title: "New question", body:"I am the question", resolved: true) }
  let (:answer) { Answer.create!(body: "I am the answer", question: question) }

  describe "attributes" do
    it "has a body attribute" do
      expect(answer).to have_attributes(body: 'I am the answer', question: question)
    end
  end
end
