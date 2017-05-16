# app.rb
# just use app.rb file to get/post, don't put a lot of logic here

require 'sinatra'
# require 'sinatra/reloader' if development?  # automatically reload app.rb on save via sinatra-contrib gem
require_relative 'isbn_check.rb'  # load Ruby script (same directory)

get '/' do  # route to load the ISBN Validator page
  @title = "ISBN Validator"  # instance variable for page name and header
  erb :isbn_input  # load isbn_input.erb file (mainly a placeholder, populated via layout.erb)
end

post '/isbn_results' do  # route that accesses input from form's post > action (line 24 of layout.erb)
  @title = "ISBN Validator Results"  # instance variable for page name and header
  @num = params[:ISBN]  # params used to access input from post > action (name="ISBN")
  @status = is_too_small?(@num)  # ISBN validation status after evaluation via isbn_check.rb
  erb :isbn_status  # load isbn_status.erb file with ISBN check results output
end