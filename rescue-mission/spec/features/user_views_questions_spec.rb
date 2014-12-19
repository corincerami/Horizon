require "rails_helper"

feature "User views the questions index" do
  #   As a user
  # I want to view recently posted questions
  # So that I can help others

  # Acceptance Criteria

  # - I must see the title of each question
  # - I must see questions listed in order, most recently posted first
  it "sees the questions" do
    question_1 = Question.create(title: "I have a question that is at least 40 characters long so I hope this is long enough", description: "I am writing a very long questions that is more than one hundred and fifty characters. What is my question, you may ask? Well, I'll explain it quite succinctly.")
    question_2 = Question.create(title: ("Lorem ipsum" * 10), description: ("blah blah blah" * 15))
    visit '/questions'
    expect(page).to have_content(question_1.title)
    expect(page).to have_content(question_2.title)
    expect(page).to have_selector("ul#questions li:nth-child(1)", text: question_2.title)
    expect(page).to have_selector("ul#questions li:nth-child(2)", text: question_1.title)
  end
end
