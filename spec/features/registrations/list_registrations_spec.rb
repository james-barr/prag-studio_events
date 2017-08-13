require "rails_helper"

describe "viewing the list of registrations - " do

  it "shows all relevant registration fields" do
    event = Event.create event_attributes
    e2 = Event.create event_attributes2
    registration = event.registrations.create registration_attributes
    r2 = e2.registrations.create registration_attributes2
    r3 = event.registrations.create registration_attributes3
    visit event_registrations_path(event)

    expect(page).to have_link registration.name, :href => "mailto:#{registration.email}"
    expect(page).to have_text registration.location
    expect(page).to have_text registration.how_heard
    expect(page).to have_text r3.how_heard
    expect(page).not_to have_text r2.location
    expect(page).not_to have_text r2.how_heard
  end

end
