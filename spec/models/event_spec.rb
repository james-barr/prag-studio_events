require "rails_helper"

describe "An event" do

  it "is free if the price is $0" do
    event = Event.create(price: 0)

    expect(event.free?).to eq(true)
  end

  it "is not free if the price is non-$0" do
    event = Event.create(price: 20)

    expect(event.free?).to eq(false)
  end

  it "is free if the price is blank" do
    event = Event.create(price: nil)

    expect(event.free?).to eq(true)
  end

  it "shows previously released events, in order" do
    event1 = Event.create event_attributes(starts_at: 9.days.from_now)
    event2 = Event.create event_attributes(starts_at: 29.days.from_now)
    event3 = Event.create event_attributes(starts_at: 19.days.from_now)
    event4 = Event.create event_attributes(starts_at: 29.days.ago)

    expect(Event.upcoming.to_a).to eq([event1, event3, event2])
  end

  it "validates that a name is present " do
    event = Event.new name: ""
    event.valid?
    expect(event.errors[:name].any?).to eq(true)
  end

  it "validates that a location cannot be blank " do
    event = Event.new location: ""

    event.valid?

    expect(event.errors[:location].any?).to eq(true)
  end

  it "validates that location can be a string of any # of chars" do
    event = Event.new location: "A"

    event.valid?

    expect(event.errors[:location].any?).to eq false
  end

  it "validates that a description is present & at least 25 characters long" do
    event = Event.new description: "1 2 3 4"

    event.valid?

    expect(event.errors[:description].any?).to eq(true)
  end

  it "validates that a description is present & no more than 150 characters long" do
    event = Event.new description: "123456789 123456789 123456789 123456789
     123456789  123456789  123456789  123456789  123456789  123456789
      123456789  123456789  123456789  123456789  123456789  123456789
       123456789  123456789"

     event.valid?

     expect(event.errors[:description].any?).to eq(true)
  end

  it "valides that price is not a string" do
    event = Event.new price: "1.a"

    event.valid?

    expect(event.errors[:price].any?).to eq(true)
  end

  it "validates that price is not a negative" do
    event = Event.new price: -1

    event.valid?

    expect(event.errors[:price].any?).to eq(true)
  end

  it "validates that price can be zero" do

    event = Event.new price: 0

    event.valid?

    expect(event.errors[:price].any?).to eq(false)

  end

  it "validates that price can be a positive decimal" do

    event = Event.new price: 1.3

    event.valid?

    expect(event.errors[:price].any?).to eq(false)
  end

  it "validates that capacity is not a string" do
    event = Event.new capacity: "cat"

    event.valid?

    expect(event.errors[:capacity].any?).to eq true
  end

  it "validates that capacity cannot be a decimal" do
    event = Event.new capacity: 1.1

    event.valid?

    expect(event.errors[:capacity].any?).to eq true
  end

  it "validates that capacity can't be zero" do
    event = Event.new capacity: 0

    event.valid?

    expect(event.errors[:capacity].any?).to eq true
  end

  it "validates that capacity can be a positive integer" do
    event = Event.new capacity: 100

    event.valid?

    expect(event.errors[:capacity].any?).to eq(false)
  end

  it "validates that the image file can be left blank" do
    event = Event.new image_file_name: ""

    event.valid?

    expect(event.errors[:image_file_name].any?).to eq false
  end

  it "validates that image file can't end with non-allowed pattern" do
    event = Event.new image_file_name: "ais.yml"

    event.valid?

    expect(event.errors[:image_file_name].any?).to eq true
  end

  it "validates that image file can end with gif, png,or jpg and can have caps
  or other 'word' characters" do
    image_name = ["x.gif", "kittycat1.jpg", ".1.png", "AAA.jpg"]
    image_name.each do |file|
      event = Event.new image_file_name: file
      event.valid?
      expect(event.errors[:image_file_name].any?).to eq false
    end
  end

  it "validates that image cannot just be file extension" do
    event = Event.new image_file_name: ".gif"

    event.valid?

    expect(event.errors[:image_file_name].any?).to eq true
  end

  it "is valid with all valid movie attributes" do
    event = Event.new event_attributes
    event.valid?
    expect(event.errors.any?).to eq false
  end

  it "has many registrations" do
    e = Event.new event_attributes
    r = e.registrations.new registration_attributes
    r2 = e.registrations.new registration_attributes2
    expect(e.registrations).to include r
    expect(e.registrations).to include r2
  end

  it "deletes associated registrations when event is deleted" do
    e = Event.create event_attributes
    r1 = e.registrations.create registration_attributes
    expect {e.destroy}.to change(Registration, :count).by(-1)
  end

  it "calculates the number of spots left" do
    e = Event.create event_attributes
    r = e.registrations.new registration_attributes
    expect(e.spots_left).to eq 99
  end

  it "determines if there are any spots left" do
    e = Event.create event_attributes(capacity: 1)
    r = e.registrations.create registration_attributes
    expect(e.sold_out?).to eq false
  end
end
