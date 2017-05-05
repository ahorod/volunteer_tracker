class Project
  attr_reader(:name,:info,:id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @info = attributes.fetch(:info)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    returned_projects.each() do |project|
      name = project.fetch("name")
      info = project.fetch("info")
      id = project.fetch("id").to_i()
      projects.push(Project.new({:name => name, :info => info, :id => id}))
    end
    projects
  end

  define_singleton_method(:find) do |id|
    result = DB.exec("SELECT * FROM projects WHERE id = #{id};")
    name = result.first().fetch("name")
    info = result.first().fetch("info")
    Project.new({:name => name, :info => info, :id => id})
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO projects (name, info) VALUES ('#{@name}', '#{@info}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_project|
    self.name().==(another_project.name()).&(self.id().==(another_project.id()))
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @info = attributes.fetch(:info, @info)
    @id = self.id()
    DB.exec("UPDATE projects SET name = '#{@name}' WHERE id = #{@id};")
    DB.exec("UPDATE projects SET info = '#{@info}' WHERE id = #{@id};")

    attributes.fetch(:volunteer_ids, []).each() do |volunteer_id|
    DB.exec("INSERT INTO assignments (volunteer_id, project_id) VALUES (#{volunteer_id}, #{self.id()});")
  end
  end

  define_method(:delete) do
    DB.exec("DELETE FROM projects WHERE id = #{self.id()};")
  end

  define_method(:volunteers) do
  project_volunteers = []
  results = DB.exec("SELECT volunteer_id FROM assignments WHERE project_id = #{self.id()};")
  results.each() do |result|
    volunteer_id = result.fetch("volunteer_id").to_i()
    volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{volunteer_id};")
    name = volunteer.first().fetch("name")
    project_volunteers.push(Volunteer.new({:name => name, :id => volunteer_id}))
  end
  project_volunteers
end
end
