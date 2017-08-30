require "rails_helper"

describe "Creating new user: " do

  it "shows all required fields" do
    visit new_user_path
    expect(page).to have_text "Name"
    expect(page).to have_text "Email"
    expect(page).to have_text "Password"
    e(page).to have_text "Username"
    expect(page).to have_text "Confirm Password"
  end

  it "fails if all fields are blank & error messages appears" do
    visit signup_path
    click_button "Create Account"
    expect(current_path).to eq users_path
    e(page).to have_text "errors"
  end

  it "creates the user and redirects to user show with a success flash, if no issues" do
    visit signup_path
    fill_in "Name", with: "C"
    fill_in "Email", with: "w@w"
    fill_in "Password", with: "X"
    fill_in "Username", with: "cwow"
    fill_in "Confirm Password", with: "X"
    click_button "Create Account"
    e(current_path).to eq user_path(User.first)
    e(page).to have_text "signed up"
    e(page).to have_link "C"
    e(page).not_to have_link "Sign In"
    e(page).not_to have_link "Signup"
    e(page).not_to have_text "Liked:"
    e(page).to have_title "Events - C"
  end
end
