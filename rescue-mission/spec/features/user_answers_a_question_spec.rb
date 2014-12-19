require 'rails_helper'

feature "User answers a question" do
  #   As a user
  # I want to answer another user's question
  # So that I can help them solve their problem

  # Acceptance Criteria

  # - I must be on the question detail page
  # - I must provide a description that is at least 50 characters long
  # - I must be presented with errors if I fill out the form incorrectly
  it "replies to a question" do
    question_1 = Question.create(title: "I have a question that is at least 40 characters long so I hope this is long enough", description: "I am writing a very long questions that is more than one hundred and fifty characters. What is my question, you may ask? Well, I'll explain it quite succinctly.")
    visit questions_path

    click_on question_1.title

    click_on "Answer this Question"

    fill_in "Answer", with: "This is an answer to the question that this person asked and this is an answer that is at least 50 characters long."

    click_on "Submit Answer"

    expect(page).to have_content("Answer successfully submitted")
    expect(page).to have_content("This is an answer to the question that this person asked and this is an answer that is at least 50 characters long.")
  end

  it "replies to a question with invalid input" do
    question_1 = Question.create(title: "I have a question that is at least 40 characters long so I hope this is long enough", description: "I am writing a very long questions that is more than one hundred and fifty characters. What is my question, you may ask? Well, I'll explain it quite succinctly.")
    visit question_path(question_1)

    click_on "Answer this Question"

    fill_in "Answer", with: "not long enough"

    click_on "Submit Answer"

    expect(page).to have_content("Description is too short (minimum is 50 characters)")
    expect(page).not_to have_content("not long enough")
  end
end
