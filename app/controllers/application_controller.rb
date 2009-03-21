# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :all # include all helpers, all the time
  filter_parameter_logging :password, :password_confirmation

  before_filter :recommend_part
  def recommend_part
    @recommend_part ||= Part.recommend
  end

  helper_method :current_user_session, :current_user
private
  def current_user_session
    @current_user_session ||= UserSession.find
  end

  def current_user
    @current_user ||= current_user_session && current_user_session.user
  end

  def require_login
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      respond_to do |format|
        format.html {redirect_to login_url}
        format.js {redirect_to '/user_session/new.js'}
      end
    end
  end

  def require_logout
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to account_url
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

end
