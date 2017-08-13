
def registration_attributes(override = {})
  {
    name: "Shurley",
    email: "shurley@gmail.com",
    how_heard: 'Blog Post',
    location: "NY"
  }.merge override
end
def registration_attributes2(override = {})
  {
    name: "Mike",
    email: "m@g.c",
    how_heard: 'Twitter',
    location: "CO",
  }.merge override
end
def registration_attributes3(override = {})
  {
    name: "Dave",
    email: "d@e.c",
    how_heard: 'Newsletter',
    location: "Mexico, Country",
  }.merge override
end
