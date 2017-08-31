require "rails_helper"

describe "An event" do

  before do
    @u = User.create! user_attributes
  end

  it "is free if the price is $0" do
    event = Event.create(price: 0)
    e(event.free?).to eq(true)
  end

  it "is not free if the price is non-$0" do
    event = Event.create(price: 20)
    e(event.free?).to eq(false)
  end

  it "is free if the price is blank" do
    event = Event.create(price: nil)
    e(event.free?).to eq(true)
  end

  it "shows previously released events, in order" do
    event1 = Event.create event_attributes(starts_at: 9.days.from_now)
    event2 = Event.create event_attributes2(starts_at: 29.days.from_now)
    event3 = Event.create event_attributes3(starts_at: 29.days.ago)
    e(Event.upcoming).to include event1
    e(Event.upcoming).to include event2
    e(Event.upcoming).not_to include event3
  end

  it "validates that a name is present " do
    event = Event.new name: ""
    event.valid?
    e(event.errors[:name].any?).to eq(true)
  end

  it "validates that a location cannot be blank " do
    event = Event.new location: ""

    event.valid?

    e(event.errors[:location].any?).to eq(true)
  end

  it "validates that location can be a string of any # of chars" do
    event = Event.new location: "A"

    event.valid?

    e(event.errors[:location].any?).to eq false
  end

  it "validates that a description is present & at least 25 characters long" do
    event = Event.new description: "1 2 3 4"

    event.valid?

    e(event.errors[:description].any?).to eq(true)
  end

  it "validates that a description is present & no more than 150 characters long" do
    event = Event.new description: "123456789 123456789 123456789 123456789
     123456789  123456789  123456789  123456789  123456789  123456789
      123456789  123456789  123456789  123456789  123456789  123456789
       123456789  123456789"

     event.valid?

     e(event.errors[:description].any?).to eq(true)
  end

  it "valides that price is not a string" do
    event = Event.new price: "1.a"

    event.valid?

    e(event.errors[:price].any?).to eq(true)
  end

  it "validates that price is not a negative" do
    event = Event.new price: -1

    event.valid?

    e(event.errors[:price].any?).to eq(true)
  end

  it "validates that price can be zero" do

    event = Event.new price: 0

    event.valid?

    e(event.errors[:price].any?).to eq(false)

  end

  it "validates that price can be a positive decimal" do

    event = Event.new price: 1.3

    event.valid?

    e(event.errors[:price].any?).to eq(false)
  end

  it "validates that capacity is not a string" do
    event = Event.new capacity: "cat"

    event.valid?

    e(event.errors[:capacity].any?).to eq true
  end

  it "validates that capacity cannot be a decimal" do
    event = Event.new capacity: 1.1

    event.valid?

    e(event.errors[:capacity].any?).to eq true
  end

  it "validates that capacity can't be zero" do
    event = Event.new capacity: 0

    event.valid?

    e(event.errors[:capacity].any?).to eq true
  end

  it "validates that capacity can be a positive integer" do
    event = Event.new capacity: 100

    event.valid?

    e(event.errors[:capacity].any?).to eq(false)
  end

  it "is valid with all valid movie attributes" do
    event = Event.new event_attributes
    event.valid?
    e(event.errors.any?).to eq false
  end

  it "has many registrations" do
    u2 = User.create! user_attributes2
    e = Event.new event_attributes
    r = e.registrations.new registration_attributes
    r2 = e.registrations.new registration_attributes2
    r.user = @u; r.save!
    r2.user = u2; r2.save!
    e(e.registrations).to include r
    e(e.registrations).to include r2
  end

  it "deletes associated registrations when event is deleted" do
    e = Event.create! event_attributes
    r1 = e.registrations.new registration_attributes
    r1.user = @u; r1.save!
    expect {e.destroy}.to change(Registration, :count).by(-1)
  end

  it "calculates the number of spots left" do
    e = Event.create event_attributes
    r = e.registrations.new registration_attributes
    r.user = @u; r.save!
    e(e.spots_left).to eq 99
  end

  it "determines if there are any spots left" do
    e = Event.create event_attributes(capacity: 1)
    r = e.registrations.new registration_attributes
    r.user = @u; r.save!
    e(e.sold_out?).to eq false
  end

  it "has many likers" do
    u2 = User.create! user_attributes2
    e = Event.create! event_attributes
    l1 = e.likes.create! user: @u
    l2 = e.likes.create! user: u2
    e(e.likes.count).to eq 2
    e(e.likers).to include @u
    e(e.likers).to include u2
  end

  it "returns all events that cost less than $10" do
    ev = Event.create! event_attributes price: 9
    ev2 = Event.create! event_attributes2 price: 11
    e(Event.costs_less_than 10).to include ev
    e(Event.costs_less_than 10).not_to include ev2
  end

  it "returns all events that cost more than $10" do
    ev = Event.create! event_attributes price: 11
    ev2 = Event.create! event_attributes2 price: 9
    e(Event.costs_more_than 10).to include ev
    e(Event.costs_more_than 10).not_to include ev2
  end

  it "returns all events that were created within last 3 days" do
    ev = Event.create! event_attributes created_at: Time.now
    ev2 = Event.create! event_attributes2 created_at: (Time.now - 5.days)
    e(Event.past_n_days 3).to include ev
    e(Event.past_n_days 3).not_to include ev2
  end

  it "automatically creates a slug for a new event" do
    ev = Event.create! event_attributes
    e(ev.slug).to eq ev.name.parameterize
  end

end
