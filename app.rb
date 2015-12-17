require 'sinatra'

get '/' do
	erb :home
end

get '/order' do
	erb :order
end