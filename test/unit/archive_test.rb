require File.dirname(__FILE__) + '/../test_helper'

class ArchiveTest < Test::Unit::TestCase
  fixtures :archives

  def setup
    @a = Archive.new
  end
  # Replace this with your real tests.
  def test_truth
    assert false, 'not truth'
  end

#   should_have_many :papers
end
