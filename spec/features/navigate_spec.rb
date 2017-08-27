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

  it "allows navigation from event show to event edit" do
    u = User.create! user_attributes admin: true
    sign_in u
    event = Event.create event_attributes
    visit event_path(event)
    click_link "Edit"
    expect(current_path).to eq(edit_event_path(event))
  end

  it "navigates from events index to events new (as admin)" do
    u = User.create! user_attributes admin: true
    sign_in u
    visit events_path
    click_link "Add New Event"
    expect(current_path).to eq(new_event_path)
  end

  it "navigates from new event to new index via the cancel button (as admin)" do
    u = User.create! user_attributes admin: true
    sign_in u
    visit new_event_url
    click_link "Cancel"
    expect(current_path).to eq(events_path)
  end

  it "navigates between registrations index to event show" do
    u = User.create! user_attributes
    event = Event.create! event_attributes
    r = event.registrations.new registration_attributes
    r.user = u; r.save!
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
    e(current_path).to eq new_event_registration_path(e)
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
    e(current_path).to eq new_session_path
  end

  it "navigates from events show to new user (aside)" do
    e = Event.create event_attributes
    visit event_path(e)
    click_link "Sign Up"
    e(current_path).to eq signup_path
  end

  it "the user form's cancel button brings the user back to root" do
    u = User.create! user_attributes
    visit new_user_path(u)
    click_link "Cancel"
    e(current_path).to eq root_path
  end

  it "header navigates from 'sign in' to signin_path" do
    visit events_path
    click_link "Sign In"
    e(current_path).to eq signin_path
  end

  it "navigates from signin_path to signup" do
    visit signin_path
    click_link "Sign Up", match: :first
    e(current_path).to eq signup_path
  end


end
