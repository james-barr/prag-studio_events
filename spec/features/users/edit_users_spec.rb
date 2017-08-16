require 'rails_helper'

describe "Editing a User: " do

  it "does not save an edit with invalid field(s) and shows errors" do
    u = User.create! user_attributes
    visit user_path(u)
    click_link "Edit User"
    fill_in "Name", with: ""
    click_button "Update Account"
    e(current_path). to eq user_path(u)
    e(page).to have_text "error"
  end

  it "saves a valid edit, redirects to show_user and displays flash" do
    u = User.create! user_attributes
    visit edit_user_path(u)
    fill_in "Email", with: "Xxx1@y.com"
    click_button "Update Account"
    e(current_path).to eq user_path(u)
    e(page).to have_text "User updated"
  end

end
