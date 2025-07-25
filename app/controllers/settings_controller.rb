class SettingsController < ApplicationController
  before_action :require_login

  def index
  end

  private

  def require_login
    redirect_to root_path, alert: "You must be logged in to access settings" unless logged_in?
  end
end
