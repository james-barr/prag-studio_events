class CategoriesController < ApplicationController
  before_action :require_signin
  before_action :find_event

  def index
    @categories = Category.all
  end

end
