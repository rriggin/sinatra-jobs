require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'sinatra-authentication'
require 'haml'

# Set up Database Connection
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/kciodev')
use Rack::Session::Cookie, :secret => 'superdupersecret'

# Set up Sinatra Auth Views
set :sinatra_authentication_view_path, Pathname(__FILE__).dirname.expand_path + "views/users"

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
  @title = "kc.io - Kansas City Marketing & Tech Jobs"
  haml :home
end

# about page
get '/about' do
  @title = "kc.io - About"
  haml :about
end

# view a list of jobs
get '/list' do
  @title = "Job List"
  @jobs = Job.all(:order => [:created_at.desc])
  haml :list
end

# create a new job 
get '/new' do
  @title = "Post a New Job"
  haml :new
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

# view a job by id
get '/show/:id' do
  @title = "Job Details"
  @job = Job.get(params[:id])
  if @job
    haml :show
  else
    redirect('/list')
  end
end
