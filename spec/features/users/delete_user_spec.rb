require "rails_helper"

describe "Deleting a user: " do

  it "deletes a user from the db, redirects to root, displays a flash" do
    u = User.create! user_attributes
    u2 = User.create! user_attributes2
    sign_in u
    visit user_path(u)
    click_link "Delete User"

    e(current_path).to eq root_path
    e(page).to have_text "deleted"
  end


end
