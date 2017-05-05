require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})

get('/') do
  @projects = Project.all()
  @volunteers = Volunteer.all()
  erb(:index)
end

post('/add_project') do
  name = params[:name]
  info = params[:info]
  new_project = Project.new({:name => name, :info => info, :id => nil})
  new_project.save()
  @projects = Project.all()
  @volunteers = Volunteer.all()
  erb(:index)
end

post('/add_volunteer') do
  name = params[:name]
  new_volunteer = Volunteer.new({:name => name, :id => nil})
  new_volunteer.save()
  @volunteers = Volunteer.all()
  @projects = Project.all()
  erb(:index)
end

get('/volunteers/:id') do
  @volunteer = Volunteer.find(params[:id].to_i())
  @projects = Project.all()
  erb(:volunteer)
end

patch('/volunteers/:id') do
  @volunteer = Volunteer.find(params[:id].to_i())
  if params[:name] != ""
    name = params[:name]
    @volunteer.update({:name => name})
  end
  @projects = Project.all()
  erb(:volunteer)
end

delete('/volunteers/:id') do
  @volunteer = Volunteer.find(params[:id].to_i())
  @volunteer.delete()
  @volunteers = Volunteer.all()
  @projects = Project.all()
  erb(:index)
end

get('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @volunteers = Volunteer.all()
  erb(:project)
end

patch('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  if params[:name] != ''
    name = params[:name]
    @project.update({:name => name})
  end
  if params[:info] != ''
    info = params[:info]
    @project.update({:info => info})
  end
  if params["volunteer_ids"] != nil
    volunteer_ids = params["volunteer_ids"]
    @project.update({:volunteer_ids => volunteer_ids})
  end
  @project = Project.find(params[:id].to_i())
  @volunteers = Volunteer.all()
  erb(:project)
end

delete('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @project.delete()
  @projects = Project.all()
  @volunteers = Volunteer.all()
  erb(:index)
end

post('/clear_all') do
  clear_all()
  @projects = Project.all()
  @volunteers = Volunteer.all()
  erb(:index)
end

def clear_all
  DB.exec("DELETE FROM projects *;")
  DB.exec("DELETE FROM assignments *;")
  DB.exec("DELETE FROM volunteers *;")
end
