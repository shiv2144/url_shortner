class UsersTest < ActionDispatch::IntegrationTest
    test 'user signup post' do
        post '/v1/signup.json',
        {user:
           {name:'shiv', email:'shiv@test.com', password: '123456', password_confirmation: '123456'}
        }.to_json,
        {'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

        assert_equal 200, response.status
        assert_equal Mime::JSON, response.content_type

        user = json(response.body)
        assert_equal url_for(controller: 'users', action: 'show', id: user[:id]), response.location
    end

def setup
    @user = users(:shiv1)
end


    test "login with valid information" do
      post '/v1/login.json',
          {session:
               {email: @user.email, password: '123456'}
            }.to_json,
            {'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
      assert_equal 200, response.status
      assert_equal Mime::JSON, response.content_type
      assert is_logged_in?

      assert_not is_logged_in?
    end
end
