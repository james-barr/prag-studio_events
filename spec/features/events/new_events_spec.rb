require "rails_helper"

describe "Create an event" do

  before do
    @admin = User.create! user_attributes admin: true
    sign_in @admin
    @c1 = Category.create! name: "C1"
    @c2 = Category.create! name: "C2"
    @c3 = Category.create! name: "C3"
  end

  it "has all necessary fields, saves event, and shows the event's attributes (as admin)" do
    visit new_event_url
    e(page).to have_text "Add New Event"
    fill_in "Name", with: "New Event"
    fill_in "Description", with: "Some new event with a description that's long enough to satisfy validation."
    fill_in "Location", with: "CO"
    fill_in "Price", with: 150.00
    select (Time.now.year - 1).to_s, :from => "event_starts_at_1i"
    attach_file "Image", "#{Rails.root}/app/assets/images/placeholder.png"
    fill_in "Capacity", with: 2
    check @c1.name
    check @c2.name
    check @c3.name
    click_button "Create Event"
    expect(current_path).to eq(event_path(Event.last))
    e(page).to have_text "New Event"
    e(page).to have_text "Some new event"
    e(page).to have_text "CO"
    e(page).to have_selector "p.flash_notice"
    within "aside#sidebar" do
      e(page).to have_text "C1"
      e(page).to have_text "C2"
    end
    e(page).to have_title "Events - New Event"
  end

  it "does not save a new invalid event (as admin)" do
    visit new_event_url
    click_button "Create Event"
    e(page).to have_text "error"
    expect(current_path).to eq events_path
  end

end
