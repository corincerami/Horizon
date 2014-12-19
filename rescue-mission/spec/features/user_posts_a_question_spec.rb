require 'rails_helper'

feature "User posts a question" do
  # As a user
  # I want to post a question
  # So that I can receive help from others

  # Acceptance Criteria

  # - I must provide a title that is at least 40 characters long
  # - I must provide a description that is at least 150 characters long
  # - I must be presented with errors if I fill out the form incorrectly
  it "posts a valid question" do
    visit '/questions/new'
    title = "x" * 41
    description = 'x' * 151
    fill_in "Title", with: title
    fill_in "Description", with: description
    click_on "Submit Question"

    expect(page).to have_content("Question posted successfully.")
    expect(page).to have_content(title)
    expect(page).to have_content(description)
  end

  it "posts invalid data to form" do
    visit '/questions/new'
    fill_in "Title", with: "Huh?"
    fill_in "Description", with: "What?"
    click_on "Submit Question"

    expect(page).to have_content("Title is too short. Must be 40 characters")
    expect(page).to have_content("Description is too short. Must be 150 characters")
  end

  it "submits an empty form" do
    visit '/questions/new'
    click_on "Submit Question"
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

end
