class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def edit
    @tags = Tag.all
  end

  def update
    params[:tags].each{|e| Tag.find(e[0]).update_attribute(:name, e[1])}
    logger.info params[:tags].class
  end
end
