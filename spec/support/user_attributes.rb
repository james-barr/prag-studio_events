def user_attributes(override = {})
  {
    name: "Sean",
    email: "s@g",
    password: "secret",
    password_confirmation: "secret",
  }.merge override
end
def user_attributes2(override = {})
  {
    name: "Carrie",
    email: "x@p.com",
    password: "meow",
    password_confirmation: "meow",
  }.merge override
end
def user_attributes3(override = {})
  {
    name: "June",
    email: "1@2",
    password: "dude",
    password_confirmation: "dude",
  }.merge override
end

public


def v?
  valid?
end

def e(*args)
  expect(*args)
end

def created_at_present
  created_at.strftime("%B %d, %Y")
end
