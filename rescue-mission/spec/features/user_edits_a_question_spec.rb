require "rails_helper"

describe "User edits a question" do
  it "Submits valid information on question edit page" do
    # As a user
    # I want to edit a question
    # So that I can correct any mistakes or add updates

    # Acceptance Criteria

    # - I must provide valid information
    # - I must be presented with errors if I fill out the form incorrectly
    # - I must be able to get to the edit page from the question details page
    question = Question.create(title: "This is a valid question title.  Here are some more characters for you.", description: "This is a long description for my question that needs to have a lot of characters. There are hopefully more than one-hundred and fifty characters here.")

    visit question_path(question)

    click_on "Edit Question"

    fill_in "Title", with: "This is a new title for my question. I am sure it's going to be a good one, because before I had some mistakes."
    fill_in "Description", with: "Here is a new description for this question. I need to make it long and fill it with words that don't mean anything. So here I go! Here are some more words for you."



    click_on "Submit Question"


    expect(page).to have_content("Question saved")
    expect(page).to have_content("This is a new title for my question. I am sure it's going to be a good one, because before I had some mistakes.")
    expect(page).to have_content("Here is a new description for this question. I need to make it long and fill it with words that don't mean anything. So here I go! Here are some more words for you.")
    expect(page).not_to have_content("This is a valid question title.  Here are some more characters for you.")
    expect(page).not_to have_content("This is a long description for my question that needs to have a lot of characters. There are hopefully more than one-hundred and fifty characters here.")
  end



  it "submits a title that is too short." do

    question = Question.create(title: "This is a valid question title.  Here are some more characters for you.", description: "This is a long description for my question that needs to have a lot of characters. There are hopefully more than one-hundred and fifty characters here.")

    visit question_path(question)

    click_on "Edit Question"

    fill_in "Title", with: "There aren't enough letters."

    click_on "Submit Question"

    expect(page).to have_content("Title is too short. Must be 40 characters")
  end



  it "submits a description that is too short." do

    question = Question.create(title: "This is a valid question title.  Here are some more characters for you.", description: "This is a long description for my question that needs to have a lot of characters. There are hopefully more than one-hundred and fifty characters here.")

    visit question_path(question)

    click_on "Edit Question"

    fill_in "Description", with: "There aren't enough letters."

    click_on "Submit Question"

    expect(page).to have_content("Description is too short. Must be 150 characters")
  end
end
