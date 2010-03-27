require 'rubygems'
require 'sinatra'

require 'haml'

get '/styles/styles.css' do
  headers 'Content-Type' => 'text/css; charset=utf-8'
  sass :styles
end

get '/:user/:set' do
  @user = params[:user]
  @set = params[:set]

  haml :set
end

get '*' do
  haml :index
end
