class InquiriesController < ApplicationController
  before_action :reset_flash_errors

  def edit
    @inquiry ||= Inquiry.find_by_id(params[:id])
    render :edit
  end

  def create
    @user = User.find_by_email(user_params[:email]) ? User.find_by_email(user_params[:email]) : User.new(user_params)
    @unit = Unit.find_by_id(params[:unit_id])
    if @user.save
      @inquiry_params = inquiry_params
      @inquiry_params[:user_id] = @user.id
      @inquiry_params[:unit_id] = params[:unit_id]
      @inquiry = Inquiry.new(@inquiry_params)
      if @inquiry.save
        redirect_to edit_unit_inquiry_url(@unit.id, @inquiry.id)
      else
        flash[:errors] = @inquiry.errors.messages
        redirect_to unit_url(@unit)
      end
    else
      flash[:errors] = @user.errors.messages
      redirect_to unit_url(@unit)
    end
  end

  def update
    @user = User.find_by_email(user_params[:email]) ? User.find_by_email(user_params[:email]) : nil
    @inquiry = Inquiry.find_by_id(params[:id])
    if @user.nil?
      flash[:errors]["authentication_update"] = ["e-mail mismatched"]
      redirect_to edit_unit_inquiry_url(@inquiry)
    else
      if @inquiry.update(inquiry_params)
        redirect_to edit_unit_inquiry_url(@inquiry)
      else
        flash[:errors] = @inquiry.errors.messages
        redirect_to edit_unit_inquiry_url(@inquiry)
      end
    end
  end

  def destroy
    @inquiry = Inquiry.find_by_id(params[:id])
    @user = User.find_by_email(user_params[:email]) ? User.find_by_email(user_params[:email]) : nil
    if @user.nil?
      flash[:errors]["authentication_delete"] = ["e-mail mismatched"]
      redirect_to edit_unit_inquiry_url(@inquiry)
    else
      @unit = @inquiry.unit
      @inquiry.destroy
      redirect_to unit_url(@unit)
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:start_date, :end_date)
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone_number)
  end


end
