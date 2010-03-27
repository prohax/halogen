require 'rubygems'
require 'sinatra'

require 'haml'
require 'sass'

require 'coffee-script'

module Haml::Filters::Coffee
  include Haml::Filters::Base
 
  def render_with_options(text, options)
    <<END
<script type=#{options[:attr_wrapper]}text/javascript#{options[:attr_wrapper]}>
  //<![CDATA[
    #{CoffeeScript.compile(text)}
  //]]>
</script>
END
  end
end


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

get '/test' do
  haml :test
end

get '*' do
  haml :index
end
