require "rails_helper"

describe "Showing a user: " do

  it "shows all fields for user" do
    u = User.create! user_attributes
    visit user_path(u)
    expect(page).to have_text u.name
    expect(page).to have_text u.email
    expect(page).to have_text u.username
    expect(page).to have_text u.created_at_present
    e(page).to have_selector "p.profile_image"
  end

end
