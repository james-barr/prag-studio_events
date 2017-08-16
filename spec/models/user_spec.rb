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
end
