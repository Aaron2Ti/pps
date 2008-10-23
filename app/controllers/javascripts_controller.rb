class JavascriptsController < ApplicationController
  def ujs_handler
    render :update do |page|
      page << session[:ujs_script]
    end
  end
end
