require "rails_helper"

describe "Viewing the list of events" do
  it "shows the events" do
    event1 = Event.create event_attributes
    event2 = Event.create event_attributes2
    event3 = Event.create event_attributes3
    event4 = Event.create event_attributes4

    visit events_url

    expect(page).to have_text("3 Events")
    expect(page).to have_text event1.name
    expect(page).to have_text event2.name
    expect(page).to have_text event3.name
    expect(page).not_to have_text event4.name

    expect(page).to have_text(event1.location)
    expect(page).to have_text(event1.description[0..10])
    expect(page).to have_text(event1.starts_at)
    expect(page).to have_text("$10.00")
    expect(page).to have_text("100")
    expect(page).to have_selector("img[src*=bug-smash]")
    expect(page).to have_text("Spots remaining")

  end
end
