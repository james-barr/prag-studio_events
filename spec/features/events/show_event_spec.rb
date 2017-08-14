require 'rails_helper'

describe "viewing an individual event" do
  it "shows the event's details" do
    event = Event.create event_attributes price: 10.00

    visit event_url(event)

    expect(page).to have_text event.name
    expect(page).to have_text event.location
    expect(page).to have_text event.description
    expect(page).to have_text event.starts_at
    expect(page).to have_text event.capacity
    expect(page).to have_selector "img[src*=bug-smash]"
  end

  it "shows the price if the price is not $0" do
    event = Event.create(event_attributes(price: 20.00))

    visit event_url(event)

    expect(page).to have_text("$20.00")
  end

  it "shows 'free' if the price is $0" do
    event = Event.create(event_attributes(price: 0.00))

    visit event_url(event)

    expect(page).to have_text("Free")
  end

  it "shows the placeholder image if none is provided" do
    event = Event.create event_attributes(image_file_name: nil)

    visit event_url(event)

    expect(page).to have_selector "img[src*=placeholder]"
  end

  it "shows the placeholder capacity of 1 if none is provided" do
    event = Event.create event_attributes4
    visit event_url(event)
    expect(page).to have_text "1 spot"
  end

  it "submits a valid registration form, displays a success message,
  and updates the page with the new registration" do
    e = Event.create event_attributes
    visit event_url(e)
    expect(page).to have_text "Register for "
    fill_in "Name", with: "Carl"
    fill_in "Email", with: "G@c.com"
    fill_in "Location", with: "NY"
    select 'Newsletter', :from => 'How heard'
    click_button "Create Registration"
    expect(current_path).to eq event_registrations_path(e)
    expect(page).to have_link "Carl", href: "mailto:G@c.com"
    expect(page).to have_text "NY"
    expect(page).to have_text "Newsletter"
    expect(page).to have_selector "p.flash_notice"
  end

  it "rejects an invalid registration form and provides errors" do
    e = Event.create event_attributes
    visit event_url(e)
    click_button "Create Registration"
    expect(current_path).to eq event_registrations_path(e)
    expect(page).to have_text "error"
    expect(page).to have_css "section#errors"
  end

  it "displays the registration button and form, if there are spots left" do
    e = Event.create event_attributes
    visit event_url(e)
    expect(page).to have_text "Register for Event"
    expect(page).to have_selector "input#registration_name"
  end

  it "displays sold out if there are not spots left" do
    e = Event.create event_attributes(capacity: 1)
    r = e.registrations.create registration_attributes
    visit event_url(e)
    expect(page).to have_text "This event is full"
    expect(page).not_to have_text "Register for Event"
    expect(page).not_to have_selector "input#registration_name"
  end



end