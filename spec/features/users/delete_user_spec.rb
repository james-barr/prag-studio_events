require "rails_helper"

describe "Deleting a user: " do

  before(:each)do
    @u = User.create! user_attributes admin: false
    sign_in @u
  end

  it "deletes a user from the db, redirects to root, displays a flash (not admin)" do
    visit user_path(@u)
    click_link "Delete User"
    e(current_path).to eq root_path
    e(page).to have_text "deleted"
    e(page).not_to have_text "Sign Out"
    e(page).to have_text "Sign In"
  end


end
