require "rails_helper"

describe "viewing the list of registrations - " do

    before do
      @u1 = User.create! user_attributes
      sign_in @u1
      @u2 = User.create! user_attributes2
      @u3 = User.create! user_attributes3
    end

  it "shows all relevant registration fields" do
    e1 = Event.create event_attributes
    e2 = Event.create event_attributes2
    r1 = e1.registrations.new registration_attributes
    r2 = e2.registrations.new registration_attributes2
    r3 = e1.registrations.new registration_attributes3
    r1.user = @u1; r1.save
    r2.user = @u1; r2.save
    r3.user = @u1; r3.save
    visit event_registrations_path(e1)
    expect(page).to have_link r1.user.name, :href => "mailto:#{r1.user.email}"
    expect(page).to have_text r1.location
    expect(page).to have_text r1.how_heard
    expect(page).to have_text r3.how_heard
    expect(page).not_to have_text r2.location
    expect(page).not_to have_text r2.how_heard
  end

end
