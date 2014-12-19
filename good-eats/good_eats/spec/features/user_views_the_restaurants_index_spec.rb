require 'rails_helper'

feature "User visits the restaurants index page" do
  it "sees all of the restaurants" do
    restaurant_1 = FactoryGirl.create(:restaurant)
    restaurant_2 = FactoryGirl.create(:restaurant)
    visit restaurants_path

    expect(page).to have_content restaurant_1.name
    expect(page).to have_content restaurant_2.name
    expect(page).to have_content restaurant_1.description
    expect(page).to have_content restaurant_2.description
  end
end
