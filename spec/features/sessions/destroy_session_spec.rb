require 'rails_helper'

describe "Destroying a session (sign out): " do

  it "signs out and destroys the session, then redirects with a flash" do
    u = User.create! user_attributes
    sign_in u
    click_link "Sign Out"
    e(current_path).to eq root_path
    e(page).to have_text "You have signed out"
    e(page).to have_link "Sign In"
    e(page).to have_link "Sign Up"
  end

end
