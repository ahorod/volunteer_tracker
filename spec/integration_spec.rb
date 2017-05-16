require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM projects *;")
    DB.exec("DELETE FROM volunteers *;")
  end
end

describe('adding a new project', {:type => :feature}) do
  it('allows a user to add a new project') do
    visit('/')
    fill_in('project_name', :with =>'Trails')
    fill_in('info', :with =>'Repair trails')
    click_button('Add Project')
    expect(page).to have_content('Trails')
  end
end

describe('adding a new volunteer', {:type => :feature}) do
  it('allows a user to add a volunteer') do
    visit('/')
    fill_in('name', :with =>'Sally')
    click_button('Add Volunteer')
    expect(page).to have_content('Sally')
  end
end

describe('see volunteers assigned to project', {:type => :feature}) do
  it('allows a user to see all volunteers for specific project') do
    project = Project.new({:name => "Tanzania trails", :info => "Build trails in the forest", :id => nil})
    project.save()
    tommy = Volunteer.new({:name => "Tommy Jones", :id => nil})
    tommy.save()
    marge = Volunteer.new({:name => "Marge Smith", :id => nil})
    marge.save()
    project.update({:volunteer_ids => [tommy.id(), marge.id()]})
    visit('/')
    click_link('Tanzania trails')
    expect(page).to have_content('Tommy Jones Marge Smith')
  end
end

describe('see volunteer profile page', {:type => :feature}) do
  it('allows a user to see volunteer profile page') do
    tommy = Volunteer.new({:name => "Tommy Jones", :id => nil})
    tommy.save()
    marge = Volunteer.new({:name => "Marge Smith", :id => nil})
    marge.save()
    visit('/')
    click_link('Marge Smith')
    expect(page).to have_content('Volunteer name: Marge Smith')
  end
end
