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
r = e1.registrations.create!(
  name: "Shurley",
  email: "shurley@gmail.com",
  how_heard: Registration::How_heard_options.sample,
  location: "Carolina",
)
r2 = e1.registrations.create!(
  name: "Mike",
  email: "m@g.c",
  how_heard: Registration::How_heard_options.sample,
  location: "NY",
)
r3 = e2.registrations.create!(
  name: "Susan BeGood III",
  email: "sb3@sb3.net",
  how_heard: Registration::How_heard_options.sample,
  location: "Montana, CA",
)
