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
        assert_equal user_url(user[:id]), response.location
    end
end