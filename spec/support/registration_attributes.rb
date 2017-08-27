
def registration_attributes(override = {})
  {
    how_heard: 'Blog Post',
    location: "NY"
  }.merge override
end
def registration_attributes2(override = {})
  {
    how_heard: 'Twitter',
    location: "CO",
  }.merge override
end
def registration_attributes3(override = {})
  {
    how_heard: 'Newsletter',
    location: "Mexico, Country",
  }.merge override
end
