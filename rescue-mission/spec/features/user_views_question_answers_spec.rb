require 'rails_helper'

feature "User views a question's answers"  do
  it "sees the answers to the question on the question page" do
    # As a user
    # I want to view the answers for a question
    # So that I can learn from the answer

    # Acceptance Criteria

    # - I must be on the question detail page
    # - I must only see answers to the question I'm viewing
    # - I must see all answers listed in order, most recent last
    question = Question.create(title: "This is a valid question title.  Here are some more characters for you.", description: "This is a long description for my question that needs to have a lot of characters. There are hopefully more than one-hundred and fifty characters here.")
    answer = Answer.create(question_id: question.id, description: "This is a long answer to your question, sir. I'm so glad I can provide such a great answer with so many characters.")
    answer_2 = Answer.create(question_id: question.id, description: "Here's another fun answer for you! This one is probably wrong, but at least it is long enough.")

    visit question_path(question)

    expect(page).to have_content("This is a long answer to your question, sir. I'm so glad I can provide such a great answer with so many characters.")
    expect(page).to have_content("Here's another fun answer for you! This one is probably wrong, but at least it is long enough.")
  end
end
