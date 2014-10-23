
get '/' do
  erb :index
end

#----------- SESSIONS -----------


post '/sessions' do
 @user = User.find_by_username( params[:username])
  if @user.password == params[:password]
    session[:user_id] = @user.id
  end
  redirect '/'
end

get '/logout' do
  session.clear
  redirect '/'
end

#----------- USERS -----------

get '/user/:id' do
  @user = User.find(session[:user_id])
  erb :profile
end

post '/users' do
  @user = User.create(params)
  if @user
    session[:user_id] = @user.id
  end
  redirect '/'
end

#----------- MOVIES -----------

get '/movies' do
  api = RottenTomatoes::Client.new
  @movie = api.search_movies(params[:movie_title])
  # require 'pry'; binding.pry
  erb :_movie_response, layout: false
end

post '/movies' do
  user = User.find(session[:user_id])
  @movie = Movie.find_by_rt_id(params["id"])
  # require 'pry'; binding.pry
  if @movie
    user.movies << @movie
  else
    @movie = Movie.create(rt_id: params["id"], title: params["title"], year: params["year"], rating: params["rating"], img: params["img"], url: params["url"], similar_url: params["similar_url"])
    user.movies << @movie
  end
  erb :_hyplist, layout: false
end

post '/watched' do
  movie = Movie.find_by_rt_id(params["id"])
  usermovie = UserMovie.where(movie_id: movie.id, user_id: session[:user_id])[0]
  usermovie.completed = true
  usermovie.save
  erb :_hyplist, layout: false
end

post '/favorite' do
  require 'pry'; binding.pry
  movie = Movie.find_by_rt_id(params["id"])
  usermovie = UserMovie.where(movie_id: movie.id, user_id: session[:user_id])[0]
  usermovie.faved = true
  usermovie.save
  erb :_watched, layout: false
end

get '/suggestions' do
  #do this next
end