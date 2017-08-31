require 'rails_helper'

describe "Filtering events" do

  it "visits the past events path" do
    ev = Event.create! event_attributes starts_at: 1.day.ago
    visit filtered_events_path(:past)
    e(current_path).to eq filtered_events_path(:past)
    e(page).to have_text ev.name
  end

  it "visits the free events path" do
    ev = Event.create! event_attributes price: 0
    visit filtered_events_path(:free)
    e(current_path).to eq filtered_events_path(:free)
    e(page).to have_text ev.name
  end

  it "visists the recent events path" do
    ev = Event.create! event_attributes starts_at: 2.days.ago
    visit filtered_events_path(:recent)
    e(current_path).to eq filtered_events_path(:recent)
    e(page).to have_text ev.name
  end



end
