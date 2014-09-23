enable :sessions
# Homepage (Root path)
get '/' do
  erb :'index'
end


get '/tracks' do
	@tracks = Track.all
	erb :'tracks/index'
end

post '/tracks' do
	@track = Track.new(
		title: params[:title],
		author: params[:author],
		url: params[:url],
		user_id: session[:user_id]
		)

  if @track.save
    redirect '/tracks'
  else
  	@tracks = Track.all
    erb :'tracks/index'
  end
end

get '/signup' do
	erb :'signup/index'
end

post '/signup' do
	@user = User.new(
		username: params[:username],
		password: params[:password],
		email: params[:email]
		)
	if @user.save
		redirect '/login'
	else
		@error = true
		erb :'signup/index'
	end
end

get '/login' do
	erb :'login/index'
end

post '/login' do
	if User.exists?(username: params[:username], password: params[:password])
		@user = User.where(username: params[:username], password: params[:password])

		session[:user_id] = @user[0][:id]
		redirect '/tracks'
	else
		@error = true
		erb :'login/index'
	end
end

get '/logout' do
	session.clear
	erb :'login/index'
end

post '/upvote/:id' do
	
	Upvote.new(user_id: session[:user_id], track_id: params[:id]).save
	@tracks = Track.all
	redirect 'tracks'
end

get '/profile/:id' do
	@user = User.find(params[:id])
	erb :'profile/index'

end

get '/review/:id' do
	@reviews = Review.where(track_id: params[:id])
	@track = Track.find(params[:id])
	erb :'review/index'
end

post '/review/:id' do
	Review.new(track_id: params[:id] ,user_id: session[:user_id], content: params[:review]).save
	
	redirect "review/" + params[:id]

end

post '/review/:id/delete' do
	review = Review.find(params[:id])
	review.destroy
	redirect "review/" + review.track_id.to_s
end