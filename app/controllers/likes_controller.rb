class LikesController < ApplicationController
  before_action :require_signin
  before_action :set_event

  def create
    @like = @event.likes.new user: current_user
    if @like.save
      redirect_to @event, notice: "Glad you liked it!"
    else
      render @event, notice: "You've already liked this event!"
    end
  end

  def destroy
    like = current_user.likes.find(params[:id])
    like.delete
    redirect_to @event, notice: "Unliked"
  end

end
