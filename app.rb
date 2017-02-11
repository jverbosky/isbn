# app.rb
# just use app.rb file to get/post, don't put a lot of logic here

require 'sinatra'
require 'sinatra/reloader' if development?  # automatically reload app.rb on save via sinatra-contrib gem
require_relative 'isbn_check.rb'  # load Ruby script (same directory)

get '/' do
  @title = "ISBN Validator"  # instance variable for page name and header
  erb :isbn_input  # load ERB (HTML) file from /views directory
end

post '/isbn_results' do  # access input from form action
  @title = "ISBN Validator Results"  # instance variable for page name and header
  @num = params[:ISBN]  # access input from .erb form's text input (name="ISBN")
  @result = is_too_small?(@num) ? "Congratulations!" : "Sorry..."  # conditional text
  @valid = is_too_small?(@num) ? "a valid ISBN number." : "not a valid ISBN number."  # more conditional text
  erb :isbn_status
end
