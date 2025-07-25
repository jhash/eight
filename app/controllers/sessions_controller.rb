class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    
    if logged_in?
      # User is already logged in, so link the new provider to their account
      identity = current_user.identities.find_or_create_by(provider: auth.provider, uid: auth.uid)
      
      if identity.persisted?
        redirect_to root_path, notice: "#{auth.provider.humanize} account connected successfully!"
      else
        redirect_to root_path, alert: "Failed to connect #{auth.provider.humanize} account."
      end
    else
      # User is not logged in, so sign them in
      user = User.from_omniauth(auth)
      
      if user
        session[:user_id] = user.id
        redirect_to root_path, notice: "Signed in successfully"
      else
        redirect_to root_path, alert: "Authentication failed. Please try again."
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Signed out successfully"
  end

  def failure
    redirect_to root_path, alert: "Authentication failed: #{params[:message]}"
  end
end