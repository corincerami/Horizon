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

def attending?(user_id, meetup_id)
  !MeetupUser.where(user_id: user_id, meetup_id: meetup_id).empty?
end

get '/' do
  @title = "Muppets"
  erb :"meetups/index"
end

get '/meetups/create' do
  authenticate!
  erb :"meetups/create"
end

get '/meetups/:meetup_id' do
  @meetup = Meetup.find(params[:meetup_id])
  @attendees = @meetup.users
  @comments = Comment.where(meetup_id: params[:meetup_id])
  @user_attending = attending?(current_user.id, params[:meetup_id])
  erb :"meetups/show"
end

post '/meetups' do
  meetup = Meetup.create(name: params[:meetup_name],
                             location: params[:location],
                             description: params[:description])
  meetup_id = meetup.id
  if !meetup.save
    flash[:error] = meetup.errors.full_messages
    redirect '/meetups/create'
  else
    flash[:notice] = 'Muppet added successfully'
    redirect "/meetups/#{meetup_id}"
  end
end

post '/meetups/:meetup_id/join' do
  authenticate!
  MeetupUser.create(user_id: current_user.id, meetup_id: params[:meetup_id])
  flash[:notice] = "You have joined this Muppet successfully"
  redirect "/meetups/#{params[:meetup_id]}"
end

post '/meetups/:meetup_id/leave' do
  meetup_user_id = MeetupUser.where(user_id: current_user,
                                    meetup_id: params[:meetup_id]).first.id
  MeetupUser.destroy(meetup_user_id)
  flash[:notice] = "You have left this Muppet successfully"
  redirect "/meetups/#{params[:meetup_id]}"
end

post '/meetups/:meetup_id/comment' do
  comment = Comment.create(content: params[:comment],
              user_id: current_user.id, meetup_id: params[:meetup_id])
  if comment.save
    flash[:notice] = "Comment posted successfully"
  else
    flash[:error] = "Failed to post comment"
  end
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
