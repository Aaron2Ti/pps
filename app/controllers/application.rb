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
end
