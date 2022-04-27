require_relative 'my_user_model.rb'
require 'sinatra'

set :bind, '0.0.0.0'
set :port, '8080'

enable :sessions

get '/users' do
    user = User.new()
    @users = user.all()
    erb :index
end

post '/users' do
    user = User.new()
    user_info = [params['firstname'], params['lastname'], params['age'], params['password'], params['email']]
    id = user.create(user_info)
    "Successfully created the user with ID = #{id}"
end

put '/users' do
    user = User.new()
    id = session[:user_id]
    if id
        user.update(id, 'password', params['password'])
        "Successfully updated user"
    else
        "Not authorized"
    end
end

delete '/users' do
    user = User.new()
    id = session[:user_id]
    if id
        user.destroy(id)
        session.delete('user_id')
        "User successfully deleted"
    else
        "Not authorized"
    end
end


post '/sign_in' do
    user = User.new()
    id = user.match(params['email'], params['password'])
    if id
        session[:user_id] = id[0][0]
        "User logged in with id #{id}"
    else
        "User not found"
    end
end

delete '/sign_out' do
    user = User.new()
    id = session[:user_id]
    if id
        session.delete('user_id')
        "You logged out"
    else
        "Not authorized"
    end
end

