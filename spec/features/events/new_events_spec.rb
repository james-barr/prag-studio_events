require "rails_helper"

describe "Create an event" do
  it "has all necessary fields, saves movie, and shows the movie's attributes" do
    visit new_event_url

    expect(page).to have_text "Add New Event"

    fill_in "Name", with: "New Event Title"
    fill_in "Description", with: "Some new event with a description that's long enough to satisfy validation."
    fill_in "Location", with: "Denver, CO"
    fill_in "Price", with: 150.00
    select (Time.now.year - 1).to_s, :from => "event_starts_at_1i"
    attach_file "Image", "#{Rails.root}/app/assets/images/placeholder.png"
    fill_in "Capacity", with: 2

    click_button "Create Event"

    expect(current_path).to eq(event_path(Event.last))

    expect(page).to have_text "New Event Title"
    expect(page).to have_text "Some new event"
    expect(page).to have_text "Denver, CO"
    expect(page).to have_selector "p.flash_notice"
  end

  it "does not save a new invalid event" do
    visit new_event_url
    click_button "Create Event"
    expect(page).to have_text "error"
    expect(current_path).to eq events_path
  end

end
