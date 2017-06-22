class UnitsController < ApplicationController
  before_action :reset_flash_errors

  def index
    @units = Unit.all
    render :index
  end

  def show
    @unit ||= Unit.find_by_id(params[:id])
    render :show
  end

end
