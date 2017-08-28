require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before do
    @user = User.create!(user_attributes)
  end

  context "when not signed in" do

    before do
      session[:user_id] = nil
    end

    it "cannot access index" do
      get :index

      expect(response).to redirect_to signin_url
    end

    it "cannot access show" do
      get :show, params: { id: @user }

      expect(response).to redirect_to signin_url
    end

    it "cannot access edit" do
      get :edit, params: { id: @user }

      expect(response).to redirect_to signin_url
    end

    it "cannot access update" do
      patch :update, params: { id: @user }

      expect(response).to redirect_to signin_url
    end

    it "cannot access destroy" do
      delete :destroy, params: { id: @user }

      expect(response).to redirect_to signin_url
    end

  end

  context "when signed in as the wrong user" do

    before do
      @wrong_user = User.create!(user_attributes2(email: "wrong@example.com"))
      session[:user_id] = @wrong_user.id
    end

    it "cannot edit another user" do
      get :edit, params: { id: @user }
      e(response).to redirect_to root_url
    end

    it "cannot update another user" do
      patch :update, params: { id: @user }
      e(response).to redirect_to root_url
    end

    it "cannot destroy another user" do
      delete :destroy, params: { id: @user }
      e(response).to redirect_to root_url
    end

  end

  context "when signed in as an admin" do

    before do
      @admin = User.create! user_attributes2 admin: true
      session[:user_id] = @admin.id
    end

    it "allows the admin to delete a user's account & doesn't sign admin out" do
      expect{
        delete :destroy, params: { id: @user }
      }.to change(User, :count).by(-1)
    end

    it "does not allow the admin to edit a user's account" do
      get :edit, params: { id: @user }
      e(response).to redirect_to root_url
    end

    it "does not allow the admin to update a user's account" do
      patch :update, params: { id: @user }
      e(response).to redirect_to root_url
    end

  end

end
