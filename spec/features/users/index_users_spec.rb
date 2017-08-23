require 'rails_helper'

describe "Index of all users: " do

  it "lists all of the users and their attributes" do
    u1 = User.create! user_attributes
    u2 = User.create! user_attributes2
    u3 = User.create! user_attributes3
    sign_in u1
    visit users_url

    expect(page).to have_text "3 Users"
    expect(page).to have_text u1.name
    expect(page).to have_text u1.email
    expect(page).to have_text u3.name
    e(page).to have_text u2.username
    expect(page).to have_text u2.created_at_present
  end

end
