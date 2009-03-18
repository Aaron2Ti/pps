class Account::TagsController < ApplicationController
  def index
    @tags = @owner.tags
  end
end
