require 'rails_helper'

describe "liking and unliking" do

  before do
    @event = Event.create! event_attributes
    @user = User.create! user_attributes
    sign_in @user
  end

  it "the current user likes the event and shows an 'Unlike' button" do
    visit event_path @event
    e(page).to have_text "0 likes"
    expect {
      click_button "Like"
    }.to change(@event.likes, :count).by 1
    e(current_path).to eq event_path @event
    e(page).to have_text "you liked"
    e(page).to have_text "1 like"
    e(page).to have_button "Unlike"
  end

  it "the current user Unlikes an event that user previously liked and shows a 'Like' button" do
    visit event_path(@event)
    click_button "Like"
    e(page).to have_text "1 like"
    expect {
      click_button "Unlike"
    }.to change(@event.likes, :count).by -1
    e(page).to have_text "0 likes"
    e(page).to have_text "Unliked"
  end

end
