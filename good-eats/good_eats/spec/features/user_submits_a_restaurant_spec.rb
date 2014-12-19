require "rails_helper"

feature "User submits a restaurant" do
  it "sees the restaurant on the show page" do
    visit new_restaurant_path
    fill_in "Name",        with: "My restaurant"
    fill_in "Address",     with: "66 Kenzel Ave"
    fill_in "City",        with: "Nutley"
    fill_in "State",       with: "NJ"
    fill_in "Zip code",    with: "07110"
    fill_in "Description", with: "A good restaurant"
    fill_in "Category",    with: "Thai"
    click_on "Create Restaurant"

    expect(page).to have_content "Restaurant created successfully"
    expect(page).to have_content "My restaurant"
    expect(page).to have_content "66 Kenzel Ave"
    expect(page).to have_content "A good restaurant"
    expect(page).to have_content "Thai"
  end

  it "submits a blank form" do
    visit new_restaurant_path
    click_on "Create Restaurant"
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Address can't be blank"
    expect(page).to have_content "City can't be blank"
    expect(page).to have_content "State can't be blank"
    expect(page).to have_content "Zip code can't be blank"
  end
end
