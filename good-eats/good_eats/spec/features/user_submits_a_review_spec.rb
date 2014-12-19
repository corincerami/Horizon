require 'rails_helper'

feature "User submits a review" do
  it "sees the review on the restaurant page" do
    restaurant = FactoryGirl.create(:restaurant)
    visit restaurant_path(restaurant)
    click_on "Write a Review"

    select "5",     from: "Rating"
    fill_in "Body", with: "I love this eatery"
    click_on "Create Review"

    expect(page).to have_content "Review submitted successfully"
    expect(page).to have_content "Rating: 5"
    expect(page).to have_content "I love this eatery"
  end

  it "submits a blank review" do
    restaurant_1 = FactoryGirl.create(:restaurant)
    visit new_restaurant_review_path(restaurant_1)
    click_on "Create Review"

    expect(page).to have_content "Rating can't be blank"
    expect(page).to have_content "Body can't be blank"
  end
end
