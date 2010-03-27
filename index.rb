require 'rubygems'
require 'sinatra'

require 'haml'
require 'sass'

require 'coffee-script'

get '/scripts/halogen.js' do |filename|
  content_type :js
  CoffeeScript.compile File.read('views/halogen.coffee')
end

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
