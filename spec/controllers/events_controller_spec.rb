require 'rails_helper'

describe EventsController do

  before do
    @u = User.create! user_attributes admin: false
    @e = Event.create! event_attributes
    session[:user_id] = @u.id
  end

  context "Unauthorized admin access" do

    it "cannot setup new an event" do
      get :new
      e(response).to redirect_to root_url
    end

    it "cannot create an event" do
      post :create
      e(response).to redirect_to root_url
    end

    it "cannot edit an event" do
      get :edit, params: { id: @e }
      e(response).to redirect_to root_url
    end

    it "cannot update an event" do
      patch :update, params: { id: @e }
      e(response).to redirect_to root_url
    end

    it "cannot destroy an event" do
      delete :destroy, params: { id: @e }
      e(response).to redirect_to root_url
    end

  end

end
