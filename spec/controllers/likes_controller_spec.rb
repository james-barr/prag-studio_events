require 'rails_helper'

RSpec.describe LikesController, type: :controller do

  before do
    @event = Event.create! event_attributes
  end

  context "not signed in" do

    before do
      session[:user_id] = nil
    end

    it "cannot access create" do
      post :create, params: { event_id: @event }
      e(response).to redirect_to signin_url
    end

    it "cannot access destroy" do
      delete :destroy, params: { id: 1, event_id: @event }
      e(response).to redirect_to signin_url
    end

  end

end
