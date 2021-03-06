require "rails_helper"

describe "Showing a user: " do

  it "shows all fields for user" do
    u = User.create! user_attributes
    sign_in u
    visit user_path(u)
    expect(page).to have_text u.name
    expect(page).to have_text u.email
    expect(page).to have_text u.username
    expect(page).to have_text u.created_at_present
    e(page).to have_selector "p.profile_image"
    e(page).to have_css ("img[src*='#{profile_image_for(u)}']")
  end

end
