require "rails_helper"

describe "viewing the list of registrations - " do

  before do
    @u1 = User.create! user_attributes
    sign_in @u1
    @u2 = User.create! user_attributes2
    @u3 = User.create! user_attributes3
  end

  it "shows all relevant registration fields" do
    e1 = Event.create event_attributes
    e2 = Event.create event_attributes2
    r1 = e1.registrations.create! registration_attributes user: @u1
    r2 = e2.registrations.create! registration_attributes2 user: @u2
    r3 = e1.registrations.create! registration_attributes3 user: @u3
    visit event_registrations_path(e1)
    e(page).to have_text r1.location
    e(page).to have_text r1.how_heard
    e(page).to have_text r3.how_heard
    e(page).not_to have_text r2.location
    e(page).not_to have_text r2.how_heard
    e(page).to have_selector "img"
  end

end
