class TagsController < ApplicationController
  def index
    @owner = current_user
    @tags = @owner.tags
  end
end
