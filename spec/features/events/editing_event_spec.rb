require "rails_helper"

describe "Editing an event" do

  before do
    admin = User.create! user_attributes admin: true
    sign_in admin
  end

  it "allows changing of all of an event's fields (as admin)" do
    event = Event.create event_attributes
    visit edit_event_path(event)
    expect(page).to have_text(event.name)
    expect(find_field('Name').value).to eq(event.name)
    expect(find_field('Description').value).to eq(event.description)
    expect(find_field('Location').value).to eq(event.location)
  end

  it "patch's the record with updates and redirects to the edit show page (as admin)" do
    event = Event.create event_attributes
    visit edit_event_path(event)
    fill_in 'Name', with: "Cat's Meow"
    click_button 'Update Event'
    expect(current_path).to eq(event_path(event))
    expect(page).to have_text "Cat's Meow"
    expect(page).to have_selector "p.flash_notice"
  end

  it "does not update a movie that has validation errors (as admin)" do
    event = Event.create event_attributes
    visit edit_event_url(event)
    fill_in "Name", with: " "
    click_button "Update Event"
    expect(page).to have_text 'error'
    expect(current_path).to eq event_path(event)
  end
end
