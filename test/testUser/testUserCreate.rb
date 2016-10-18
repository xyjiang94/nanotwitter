require File.expand_path '../../test_helper.rb', __FILE__

class TestTweetCreate < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_create_new_user
    put '/api/v1/register/testuser/testpassword'
    user =  JSON.parse(last_response.body)
    assert_equal user["username"], "testuser"
    assert_equal Password.new(user["password"]), "testpassword"

    user = User.find_by(username: "testuser")
    user.destroy
  end
end
