require File.dirname(__FILE__) + '/../test_helper'
require 'archives_controller'

# Re-raise errors caught by the controller.
# class ArchivesController; def rescue_action(e) raise e end; end

class ArchivesControllerTest < Test::Unit::TestCase
  def setup
    @controller = ArchivesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
