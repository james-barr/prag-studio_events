def user_attributes(override = {})
  {
    name: "Sean",
    email: "s@g",
    username: "seang",
    password: "secret",
    password_confirmation: "secret",
  }.merge override
end
def user_attributes2(override = {})
  {
    name: "Carrie",
    email: "x@p.com",
    username: "carrie",
    password: "meow",
    password_confirmation: "meow",
  }.merge override
end
def user_attributes3(override = {})
  {
    name: "June",
    email: "1@2",
    username: "junebug",
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

def gravatar_id
  Digest::MD5::hexdigest(email.downcase)
end

def profile_image_for(user)
  url = "http://secure.gravatar.com/avatar/#{user.gravatar_id}"
end
