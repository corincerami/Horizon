require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'omniauth-github'

require_relative 'config/application'

Dir['app/**/*.rb'].each { |file| require_relative file }

helpers do
  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end

  def signed_in?
    current_user.present?
  end
end

def set_current_user(user)
  session[:user_id] = user.id
end

def authenticate!
  unless signed_in?
    flash[:notice] = 'You need to sign in if you want to do that!'
    redirect '/'
  end
end

get '/' do
  @title = "Muppets"
  erb :"meetups/index"
end

get '/meetups/create' do
  erb :"meetups/create"
end

get '/meetups/:id' do
  @meetup = Meetup.find(params[:id])
  erb :"meetups/show"
end

post '/meetups' do
  authenticate!
  meetup = Meetup.create(name: params[:meetup_name],
                             location: params[:location],
                             description: params[:description])
  meetup_id = meetup.id
  if meetup.errors
    flash[:error] = meetup.errors.full_messages
    redirect '/meetups/create'
  else
  flash[:notice] = 'Muppet added successfully'
  redirect "/meetups/#{meetup_id}"
  end
end

post '/meetups/:meetup_id/join' do
  MeetupUser.create(user_id: session[:user_id], meetup_id: params[:meetup_id])
  redirect "/meetups/#{params[:meetup_id]}"
end

get '/auth/github/callback' do
  auth = env['omniauth.auth']

  user = User.find_or_create_from_omniauth(auth)
  set_current_user(user)
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/example_protected_page' do
  authenticate!
end
