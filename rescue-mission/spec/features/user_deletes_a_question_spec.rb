require "rails_helper"

describe "user deletes a question"  do
  it "successfully deletes a question" do
    # As a user
    # I want to delete a question
    # So that I can delete duplicate questions

    # Acceptance Criteria

    # - I must be able delete a question from the question edit page
    # - I must be able delete a question from the question details page
    # - All answers associated with the question must also be deleted
    question = Question.create(title: "This is a valid question title.  Here are some more characters for you.", description: "This is a long description for my question that needs to have a lot of characters. There are hopefully more than one-hundred and fifty characters here.")

    visit question_path(question)

    click_on "Delete Question"

    expect(page).not_to have_content("This is a valid question title.  Here are some more characters for you.")
    expect(page).not_to have_content("This is a long description for my question that needs to have a lot of characters. There are hopefully more than one-hundred and fifty characters here.")
  end
end
