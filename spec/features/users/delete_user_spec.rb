require "rails_helper"

describe "Deleting a user: " do

  it "deletes a user from the db, redirects to user index, displays a flash, and doesn't show the user's info" do
    u = User.create! user_attributes
    u2 = User.create! user_attributes2
    visit user_path(u)
    click_link "Delete User"

    e(current_path).to eq users_path
    e(page).to have_text "deleted"
    e(page).to have_text u2.name
    e(page).to have_text u2.email
    e(page).to have_text "1 User"
  end


end
