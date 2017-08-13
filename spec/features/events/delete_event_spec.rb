require "rails_helper"

describe "Deleting an event" do
  it "deletes an event and redirects to index" do
    event = Event.create event_attributes

    visit event_url(event)

    click_link "Delete Event"

    expect(current_path).to eq(events_path)
    expect(page).not_to have_text(event.name)
    expect(page).to have_selector "p.flash_danger"

  end
end
