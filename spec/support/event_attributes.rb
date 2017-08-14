def event_create
  e = Event.create event_attributes
end

def event_attributes(overrides = {})
  {
    name: "Bugsmash",
    location: "Denver",
    price: 10.00,
    description: "A fun evening of bug smashing and friend making.",
    starts_at: 10.days.from_now,
    image: open("#{Rails.root}/app/assets/images/bug-smash.png"),
    capacity: 100
  }.merge(overrides)
end

def event_attributes2(overrides = {})
  {
    name: "Hackathon",
    location: "Austin",
    price: 15.00,
    description: "Hunker down at the Hackathon for some good ole' fun!",
    starts_at: 30.days.from_now,
    image: open("#{Rails.root}/app/assets/images/hackathon.png"),
    capacity: 10
  }.merge overrides
end

def event_attributes3(overrides = {})
  {
    name: "Kata Camp",
    location: "Dallas",
    price: 75.00,
    description: "Practice your kraft, kata style with coding pals from around town!",
    starts_at: 15.days.from_now,
    capacity: 20,
    image: open("#{Rails.root}/app/assets/images/kata-camp.jpg"),
  }.merge overrides
end

def event_attributes4(overrides = {})
  {
    name: "Old Event",
    location: "Miami",
    price: 750.00,
    description: "Live in the past by using a time machine, given by Mr. Rick Sanchez",
    starts_at: 29.days.ago,
    image: open("#{Rails.root}/app/assets/images/placeholder.png"),
  }.merge overrides
end
