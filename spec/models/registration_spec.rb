require 'rails_helper'

describe "A registration" do

  it "validates how_heard when valid" do
    r = Registration.new how_heard: Registration::How_heard_options.sample
    r.valid?
    expect(r.errors[:how_heard].any?).to eq false
  end

  it "does not validate how_heard when invalid" do
    r = Registration.new how_heard: "Your mom"
    r.valid?
    expect(r.errors[:how_heard].any?).to eq true
  end

  it "validates that location is present" do
    r = Registration.new location: ""
    r.valid?
    expect(r.errors[:location].any?).to eq true
  end

  it "invalid if does not belong to event" do
    r = Registration.new registration_attributes
    r.valid?
    expect(r.errors[:event].any?).to eq true
  end

  it "validates with valid attributes" do
    u = User.create! user_attributes
    e = Event.new event_attributes
    r = Registration.new registration_attributes(event: e, user: u)
    r.valid?
    expect(r.errors.any?).to eq false
  end

end
