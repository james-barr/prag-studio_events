require 'rails_helper'

RSpec.describe User, type: :model do
  it "is invalid without an email" do
    u = User.new user_attributes email: ""
    u.v?
    expect(u.errors[:email].any?).to eq true
  end

  it "is invalid without a name" do
    u = User.new user_attributes name: ""
    u.v?
    expect(u.errors[:name].any?).to eq true
  end

  it "rejects improperly formatted email addresses" do
    u = User.new user_attributes email: "b"
    u.v?
    expect(u.errors[:email].any?).to eq true
  end

  it "accepts properly formatted email addresses" do
    u = User.new user_attributes email: "abc@g.com"
    u.v?
    expect(u.errors[:email].any?).to eq false
  end

  it "requires a unique, case insensitive email address" do
    u = User.create! user_attributes email: "x@y.com"
    u2 = User.new user_attributes email: u.email.upcase!
    u2.v?
    expect(u2.errors[:email].any?).to eq true
  end

  it "is invalid without a password " do
    u = User.new user_attributes password: ""
    u.v?
    expect(u.errors[:password].any?).to eq true
  end

  it "requires a password confirmation when a password is present" do
    u = User.new user_attributes password: "x", password_confirmation: ""
    u.v?
    expect(u.errors[:password_confirmation].any?).to eq true
  end

  it "requires the password to match the password confirmation" do
    u = User.new user_attributes password: "x", password_confirmation: "y"
    u.v?
    expect(u.errors[:password_confirmation].any?).to eq true
  end

  it "requires a password and matching password confirmation when creating" do
    u = User.create user_attributes password: "x", password_confirmation: "x"
    expect(u.v?).to eq true
  end

  it "does not require a password when updating"  do
    u = User.create user_attributes
    u.password = ""
    expect(u.v?).to eq true
  end

  it "automatically encrypts the password into the password_digest attribute" do
    u = User.new user_attributes password: "x"
    u.v?
    expect(u.password_digest).to be_present
  end

  it "is valid with all proper fields" do
    u = User.new user_attributes
    u.v?
    expect(u.errors.any?).to eq false
  end

  it "is invalid without a username" do
    u = User.new user_attributes username: ""
    u.v?
    e(u.errors[:username].any?).to eq true
  end

  it "is invalid with a username that doesn't fit format" do
    usernames = ['x ,', ' ', ',', 'Ab,','11 11']
    usernames.each do |u|
      user = User.new user_attributes username: u
      user.v?
      e(user.errors[:username].any?).to eq true
    end
  end

  it "is invalid if username is not unique (case insensitive)" do
    u1 = User.create! user_attributes username: "x"
    u2 = User.new user_attributes2 username: u1.username.upcase
    u2.v?
    e(u2.errors[:username].any?).to eq true
  end

  it "does not authenticate with a missing username / email" do
    u = User.create! user_attributes email: "x@x", password: "X", password_confirmation: "X"
    e(User.authenticate("", "X")).not_to eq true
  end

  it "does not authenticate with a missing password" do
    u = User.create! user_attributes email: "x@x", password: "X", password_confirmation: "X"
    e(User.authenticate("x@x", "")).not_to eq true
  end

  it "authenticates with all valid credentials" do
    u = User.create! user_attributes email: "x@x", password: "X", password_confirmation: "X"
    e(User.authenticate("x@x", "X")).to eq u
  end

  it "has reviews" do
    u = User.create! user_attributes
    e1 = Event.new event_attributes
    e2 = Event.new event_attributes2
    r1 = e1.registrations.new registration_attributes
    r1.user = u
    r1.save!
    r2 = e2.registrations.new registration_attributes
    r2.user = u
    r2.save!
    e(u.registrations).to include r1
    e(u.registrations).to include r2
  end

  it "likes many events" do
    u = User.create! user_attributes
    e = Event.create! event_attributes
    e2 = Event.create! event_attributes2
    l1 = e.likes.create! user: u
    l2 = e2.likes.create! user: u
    e(u.likes.count).to eq 2
    expect(u.liked_events).to include e
    expect(u.liked_events).to include e2
  end


end
