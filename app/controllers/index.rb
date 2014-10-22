require 'bcrypt'

get '/' do
  # render home page
 #TODO: Show all users if user is signed in
  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  erb :sign_in
end

post '/sessions' do
 @user = User.find_by_email( params[:email])
  if @user.password == params[:password]
    session[:user_id] = @user.id
  end
  current_user
  redirect '/'
end

delete '/sessions/:id' do
  redirect '/'
  session = nil
end

#----------- USERS -----------

get '/users/new' do
  erb :sign_up
end

post '/users' do
  @user = User.create(params[:user])
  if @user
    session[:user_id] = @user.id
  end
  redirect '/'
end
