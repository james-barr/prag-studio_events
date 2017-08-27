# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Event.create!([
  {
    name: 'BugSmash',
    location: 'Denver, CO',
    price: 0.00,
    description: "Join us for a fun evening of bug smashing!",
    starts_at: 100.days.from_now,
    image_file_name: "bug-smash.png",
    capacity: 100
  },
  {
    name: "Hackathon",
    location: "Houston, TX",
    price: 15.00,
    description: "Hack away at the hackathon!",
    starts_at: 120.days.from_now,
    image_file_name: "hackathon.png",
    capacity: 1
  },
  {
    name: "Kata Camp",
    location: "Dallas, TX",
    price: 75.00,
    description: "Practice your coding ,kata style!",
    starts_at: 150.days.from_now,
    capacity: 20,
    image_file_name: ""
  }
])
e1 = Event.find(1)
e2 = Event.find(2)
r = e1.registrations.new(
  how_heard: Registration::How_heard_options.sample,
  location: "Carolina",
)
r2 = e1.registrations.new(
  how_heard: Registration::How_heard_options.sample,
  location: "NY",
)
r3 = e2.registrations.new(
  how_heard: Registration::How_heard_options.sample,
  location: "Montana, CA",
)

User.create!([
  {
    name: "Admin",
    email: "a@f",
    username: "admin",
    password: "x",
    password_confirmation: "x",
    admin: true
  },
  {
    name: "Jon",
    email: "j@f",
    username: "jon",
    password: "x",
    password_confirmation: "x",
  },
  {
    name: "Bob",
    email: "b@f",
    username: "bob",
    password: "x",
    password_confirmation: "x",
  },
  ])
u1 = User.find(1)
u2 = User.find(2)
u3 = User.find(3)
r.user = u1; r.save!
r2.user = u2; r2.save!
r3.user = u3; r3.save!
