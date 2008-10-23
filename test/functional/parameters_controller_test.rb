require File.dirname(__FILE__) + '/../test_helper'
require 'parameters_controller'

# Re-raise errors caught by the controller.
class ParametersController; def rescue_action(e) raise e end; end

class ParametersControllerTest < Test::Unit::TestCase
  def setup
    @controller = ParametersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
