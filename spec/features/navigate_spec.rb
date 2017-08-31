require "rails_helper"

describe "Navigating events" do

  before do
    @e = Event.create! event_attributes
    @u = User.create! user_attributes admin: true
    sign_in @u
  end

  it "allows navigation from the show page to the index page" do
    visit event_url @e
    click_link "Upcoming Events"
    expect(current_path).to eq(events_path)
  end

  it "allows navigation from the index page to the show page" do
    visit events_url
    click_link @e.name
    expect(current_path).to eq(event_path(@e))
  end

  it "allows navigation from event show to event edit" do
    visit event_path(@e)
    click_link "Edit"
    expect(current_path).to eq(edit_event_path(@e))
  end

  it "navigates from events index to events new (as admin)" do
    visit events_path
    click_link "Add New Event"
    expect(current_path).to eq(new_event_path)
  end

  it "navigates from new event to new index via the cancel button (as admin)" do
    visit new_event_url
    click_link "Cancel"
    expect(current_path).to eq(events_path)
  end

  it "navigates between registrations index to event show" do
    r = @e.registrations.new registration_attributes
    r.user = @u; r.save!
    visit event_registrations_url(@e)
    click_link "Back to event"
    expect(current_path).to eq event_path(@e)
  end

  it "navigates from event show to registrations index" do
    visit event_url(@e)
    click_link "Who's registered"
    expect(current_path).to eq event_registrations_path(@e)
  end

  it "navigates from event show to new registration" do
    visit event_url(@e)
    click_link "Register for event"
    e(current_path).to eq new_event_registration_path(@e)
  end

  it "navigates from new registration to registration index" do
    visit new_event_registration_url(@e)
    click_link "Cancel"
    expect(current_path).to eq events_path
  end

  it "navigates from events index to users index (aside)" do
    visit events_path
    click_link "All Users"
    e(current_path).to eq users_path
  end

  it "navigates from events show to new user (aside)" do
    visit event_path(@e)
    click_link "Sign Out"
    click_link "Sign Up"
    e(current_path).to eq signup_path
  end

  it "the user form's cancel button brings the user back to root" do
    visit new_user_path(@u)
    click_link "Cancel"
    e(current_path).to eq root_path
  end

  it "header navigates from 'sign in' to signin_path" do
    visit events_path
    click_link "Sign Out"
    click_link "Sign In"
    e(current_path).to eq signin_path
  end

  it "navigates from signin_path to signup" do
    visit signin_path
    click_link "Sign Up", match: :first
    e(current_path).to eq signup_path
  end


end
