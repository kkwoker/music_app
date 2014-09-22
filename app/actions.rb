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
		url: params[:url]
		)

  if @track.save
    redirect '/tracks'
  else
  	@tracks = Track.all
    erb :'tracks/index'
  end


end
