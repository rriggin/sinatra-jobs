#sinatra-jobs

This is a simple jobs app written in ruby

It is a work in progress.  Hack it up all you want. 

Tools used:

- ruby
- sinatra
- twitter bootstrap
- font awesome
- datamapper
- heroku
- postgresql
- haml

Key gems:

- sinatra-authentication *used for user authentication*

#ToDo

- clean up the user account views, add bootstrapping, etc
- make contact email field required on create new job function
- tie user model to jobs model with one > many relationship
- fix responsive layout elements
- add tagging structure with datamapper-tags
- add a geographic model (areas:  i.e, city/state, zip, region) **maybe use tags for this?
- add a featured job banner in home.haml

#Roadmap

- as a user, I'd like to share a job on facebook
- as a seeker, I'd like to browse jobs by tag
- as a company, I'd like to view a list of job I posted
