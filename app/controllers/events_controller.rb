class EventsController < ApplicationController
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.send(events_scope)
  end

  def show
    @registration = @event.registrations.new
    @likers = @event.likers
    if current_user
      @current_like = current_user.likes.find_by event_id: @event.id
    end
    @categories = @event.categories
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Event successfully updated"
    else
      render :edit
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, notice: "Event successfully created"
    else
      render :new
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, danger: "Event successfully deleted"
  end

  private

  def event_params
     params.require(:event).permit(:name, :description, :location, :price, :starts_at, :image, :capacity, category_ids: [])
  end

  def events_scope
    if params[:scope].in? %w(past free recent past_n_days costs_less_than costs_more_than)
      params[:scope]
    else
      :upcoming
    end
  end

  def set_event
    @event = Event.find_by!(slug: params[:id])
  end

end
