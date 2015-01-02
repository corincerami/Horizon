require "rails_helper"

# As a car salesperson
# I want to record a newly acquired car
# So that I can list it in my lot
# ```

# Acceptance Criteria:

# * I must specify the manufacturer, color, year, and mileage of the car (an association between the car and an existing manufacturer should be created).
# * Only years from 1920 and above can be specified.
# * I can optionally specify a description of the car.
# * If I enter all of the required information in the required formats, the car is recorded and I am presented with a notification of success.
# * If I do not specify all of the required information in the required formats, the car is not recorded and I am presented with errors.
# * Upon successfully creating a car, I am redirected back to the index of cars.

feature "User creates a car" do
  it "fills out the required information" do
    manufacturer = FactoryGirl.create(:manufacturer)
    visit root_path
    click_on "View all manufacturers"
    click_on manufacturer.name

    click_on "Create a car"

    fill_in "Color", with: "Blue"
    select "2015", from: "Year"
    fill_in "Mileage", with: "100000"
    fill_in "Description", with: "It's a car."
    click_on "Create Car"

    expect(page).to have_content "All Cars"
    expect(page).to have_content "Blue 2015 Toyota"
    expect(page).to have_content "Car created"
  end

  it "leaves required information blank" do
    manufacturer = FactoryGirl.create(:manufacturer)
    visit root_path
    click_on "View all manufacturers"
    click_on manufacturer.name

    click_on "Create a car"
    click_on "Create Car"

    expect(page).to have_content "Color can't be blank"
    expect(page).to have_content "Year can't be blank"
    expect(page).to have_content "Mileage can't be blank"
  end

  it "fills in the mileage with something other than an integer" do
    manufacturer = FactoryGirl.create(:manufacturer)
    visit root_path
    click_on "View all manufacturers"
    click_on manufacturer.name

    click_on "Create a car"

    fill_in "Color", with: "Blue"
    select "2015", from: "Year"
    fill_in "Mileage", with: "A word"
    fill_in "Description", with: "It's a car."
    click_on "Create Car"

    expect(page).to have_content "Mileage is not a number"
  end
end
