require "rails_helper"

feature "User views a question's details" do
  # As a user
  # I want to view a question's details
  # So that I can effectively understand the question

  # Acceptance Criteria

  # - I must be able to get to this page from the questions index
  # - I must see the question's title
  # - I must see the question's description
  it "goes to a question's details page" do
    question_1 = Question.create(title: "I have a question that is at least 40 characters long so I hope this is long enough", description: "I am writing a very long questions that is more than one hundred and fifty characters. What is my question, you may ask? Well, I'll explain it quite succinctly.")
    visit '/questions'
    click_on question_1.title
    expect(page).to have_content(question_1.title)
    expect(page).to have_content(question_1.description)
  end
end
