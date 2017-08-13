require "rails_helper"

describe "Confirming Footer" do
  def footer_structure
    expect(page).to have_selector('footer')
  end

  def header_structure
    expect(page).to have_selector('header')
  end

  def aside_structure
    expect(page).to have_selector('aside')
  end

  it "checks the index" do
    visit events_url

    footer_structure
    header_structure
    aside_structure
  end

  it "checks the new" do
    visit new_event_url

    footer_structure
    header_structure
    aside_structure
  end


end
