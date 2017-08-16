require "rails_helper"

describe "Creating new user: " do

  it "shows all required fields" do
    visit new_user
    expect(page).to have_text "Name"
    expect(page).to have_text "Email"
    expect(page).to have_text "Password"
    expect(page).to have_text "Password confirmation"
  end

  it "fails if all fields are not provided & an error messages appears" 

  it "creates the user and redirects to user show with a success flash, if no issues"

end
