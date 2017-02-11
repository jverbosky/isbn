# app.rb
# just use app.rb file to get/post, don't put a lot of logic here

require 'sinatra'
require 'sinatra/reloader' if development?  # automatically reload app.rb on save via sinatra-contrib gem
require_relative 'isbn_check.rb'  # load Ruby script (same directory)

get '/' do
  @title = "ISBN Validator"  # instance variable for page name and header
  erb :isbn_input  # load ERB (HTML) file from /views directory
end

post '/isbn_input' do  # access input from isbn_input.erb
  @title = "ISBN Validator Results"  # instance variable for page name and header
  num = params[:ISBN]  # access input from .erb form's text input (name="ISBN")
  # results =   # pass num to main method from isbn_check.rb
  is_too_small?(num) ? "\"#{num}\" is a valid ISBN number." : "\"#{num}\" is not a valid ISBN number."
  #  "This is a valid ISBN number: #{results}"
end
