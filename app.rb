require 'rubygems'
require 'sinatra'
require 'data_mapper'

# Set up Database Connections.  Using SQLite3 Locally & Postgres on Heroku.
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/kciodev.db')

class Job

  include DataMapper::Resource

  property :id,               Serial
  property :title,            String
  property :company,          String
  property :website,          String
  property :description,      Text
  property :created_at,       DateTime
  property :contact_email,    String

  end

configure :development do
# Create or upgrade all tables at once
DataMapper.auto_upgrade!
end

# set utf-8 for outgoing

before do 
  headers "Content-Type" => "text/html; charset=utf-8"
end

get '/' do
  @title = "kc.io"
  erb :welcome
end

get '/list' do
  @page_title = "Jobs List"
  @jobs = Job.all(:order => [:created_at.desc])
  erb :list
end

get '/new' do
  @title = "Post New Job"
  erb :new
end

post '/create' do
  @job = Job.new(params[:job])
  if @job.save
    redirect "/show/#{@job.id}"
  else
    redirect('/list')
  end
end

get '/delete/:id' do |id|
  job = Job.get(params[:id])
  job.destroy! 
  redirect('/list')
end

get '/show/:id' do
  @job = Job.get(params[:id])
  if @job
    erb :show
  else
    redirect('/list')
  end
end

