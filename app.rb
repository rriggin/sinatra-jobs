require 'rubygems'
require 'sinatra'
require 'data_mapper'

# Set up Database Connection
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/kciodev')


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

# Create or upgrade all tables at once
DataMapper.auto_upgrade!

# set utf-8 for outgoing

before do 
  headers "Content-Type" => "text/html; charset=utf-8"
end

# index page for the site
get '/' do
  @title = "kc.io"
  erb :home
end

# view a list of jobs
get '/list' do
  @title = "Job List"
  @jobs = Job.all(:order => [:created_at.desc])
  erb :list
end

# create a new job 
get '/new' do
  @title = "Post a New Job"
  erb :new
end

# post handler for new job
post '/create' do
  @job = Job.new(params[:job])
  if @job.save
    redirect "/show/#{@job.id}"
  else
    redirect('/list')
  end
end

# delete job
#get '/delete/:id' do |id|
#  job = Job.get(params[:id])
#  job.destroy! 
#  redirect('/list')
#end

# view a job by id
get '/show/:id' do
  @title = "Job Details"
  @job = Job.get(params[:id])
  if @job
    erb :show
  else
    redirect('/list')
  end
end

