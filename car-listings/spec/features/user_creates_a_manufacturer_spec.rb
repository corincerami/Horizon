require "rails_helper"

# User story

# As a car salesperson
# I want to record a car manufacturer
# So that I can keep track of the types of cars found in the lot

# Acceptance Criteria:

# * I must specify a manufacturer name and country.
# * If I do not specify the required information, I am presented with errors.
# * If I specify the required information, the manufacturer is recorded and I am redirected to the index of manufacturers

feature "User creates a car manufacturer" do
  it "fills in the required information" do
    visit root_path
    click_on "View all manufacturers"
    click_on "Create a manufacturer"

    fill_in "Name", with: "Toyota"
    fill_in "Country", with: "Japan"
    click_on "Create Manufacturer"

    expect(page).to have_content "Manufacturer created"
    expect(page).to have_content "All Manufacturers"
    expect(page).to have_content "Toyota"
  end

  it "doesn't supply the required information" do
    visit new_manufacturer_path
    click_on "Create Manufacturer"

    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Country can't be blank"
  end
end
