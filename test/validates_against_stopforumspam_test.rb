require 'test_helper'

class ValidatesAgainstStopforumspamTest < ActiveSupport::TestCase
  setup do
    Rails.env = 'production'
  end

  test "ham email" do
		assert Comment.new(:email => 'surely@not-spam-but-ham.com').valid?
  end

  test "ham ip" do
		assert Comment.new(:ip => '127.0.0.1').valid?
  end

  test "ham username" do
		assert Comment.new(:user_name => 'i-only-submit-ham').valid?
  end

  test "spam email" do
		assert Comment.new(:email => 'test@test.com').invalid?
  end

  test "spam email and ip" do
		assert Comment.new(:email => 'test@test.com', :ip => '1.2.3.4').invalid?
  end

  test "spam ip" do
		assert Comment.new(:ip => '1.2.3.4').invalid?
  end

  test "spam username" do
		assert Comment.new(:user_name => 'spammer').invalid?
  end
end
