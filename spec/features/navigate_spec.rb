require "rails_helper"

describe "Navigating events" do

  it "allows navigation from the show page to the index page" do
    event = Event.create event_attributes
    visit event_url event
    click_link "All Events"
    expect(current_path).to eq(events_path)
  end

  it "allows navigation from the index page to the show page" do
    event = Event.create event_attributes
    visit events_url
    click_link event.name
    expect(current_path).to eq(event_path(event))
  end

  it "allows navigation from show to edit" do
    event = Event.create event_attributes
    visit event_path(event)
    click_link "Edit"
    expect(current_path).to eq(edit_event_path(event))
  end

  it "navigates from index to new" do
    visit events_path
    click_link "Add New Event"
    expect(current_path).to eq(new_event_path)
  end

  it "navigates from new to index via the cancel button" do
    visit new_event_url
    click_link "Cancel"
    expect(current_path).to eq(events_path)
  end

  it "navigates between registrations index to event show" do
    event = Event.create event_attributes
    registartion = Registration.create registration_attributes
    visit event_registrations_url(event)
    click_link "Back to event"
    expect(current_path).to eq event_path(event)
  end

  it "navigates from event show to registrations index" do
    event = Event.create event_attributes
    registration = Registration.create registration_attributes
    visit event_url(event)
    click_link "Who's registered"
    expect(current_path).to eq event_registrations_path(event)
  end

  it "navigates from event show to new registration" do
    e = Event.create event_attributes
    visit event_url(e)
    click_link "Register for event"
    expect(current_path).to eq new_event_registration_path(e)
  end

  it "navigates from new registration to registration index" do
    e = Event.create event_attributes
    visit new_event_registration_url(e)
    click_link "Cancel"
    expect(current_path).to eq events_path
  end

  it "navigates from events index to users index (aside)" do
    visit events_path
    click_link "All Users"
    e(current_path).to eq users_path
  end

  it "navigates from events show to new user (aside)" do
    e = Event.create event_attributes
    visit event_path(e)
    click_link "New User"
    e(current_path).to eq new_user_path
  end


end
