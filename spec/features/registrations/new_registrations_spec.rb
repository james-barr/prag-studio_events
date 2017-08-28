require "rails_helper"

describe "Create new registration for event - " do

  before do
    @u = User.create! user_attributes admin: true
    sign_in @u
    @e = Event.create! event_attributes
  end

  it "expect page to save a valid registration and redirect" do
    visit new_event_registration_url(@e)
    expect(page).to have_text "Register for "
    fill_in "Location", with: "NY"
    select 'Newsletter', :from => 'How heard'
    click_button "Create Registration"
    expect(current_path).to eq event_registrations_path(@e)
    expect(page).to have_text "NY"
    expect(page).to have_text "Newsletter"
    expect(page).to have_selector "p.flash_notice"
  end

  it "Does not submit invalid registrations" do
    visit new_event_registration_url(@e)
    click_button "Create Registration"
    expect(current_path).to eq event_registrations_path(@e)
    expect(page).to have_text "error"
    expect(page).to have_css "section#errors"
  end
end
