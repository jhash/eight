class Admin::BaseController < ApplicationController
  before_action :require_superadmin

  private

  def require_superadmin
    unless current_user&.superadmin?
      flash[:alert] = "You must be a superadmin to access this area"
      redirect_to root_path
    end
  end
end
