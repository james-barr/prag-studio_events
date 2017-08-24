require 'rails_helper'

describe "Signing in: " do

  it "redirects to the user's intended destination" do
    u = User.create! user_attributes
    visit users_path
    sign_in u
    e(current_path).to eq users_path
  end

end
