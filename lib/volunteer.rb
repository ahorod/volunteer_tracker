class Volunteer
  attr_accessor(:name)
  attr_reader(:id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    returned_volunteers.each() do |volunteer|
      name = volunteer.fetch("name")
      id = volunteer.fetch("id").to_i()
      volunteers.push(Volunteer.new({:name => name, :id => id}))
    end
    volunteers
  end


  define_singleton_method(:find) do |id|
    result = DB.exec("SELECT * FROM volunteers WHERE id = #{id};")
    name = result.first().fetch("name")
    Volunteer.new({:name => name, :id => id})
  end

  define_singleton_method(:free) do
    free_volunteer = Volunteer.all().delete_if {|volunteer| volunteer.is_assigned() }
  end

  define_method(:is_assigned) do
    results = DB.exec("SELECT * FROM assignments WHERE volunteer_id = #{self.id()};")
    results.each() do |result|
      return true
    end
    return false
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO volunteers (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_volunteer|
    self.name().==(another_volunteer.name()).&(self.id().==(another_volunteer.id()))
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM volunteers WHERE id = #{self.id()};")
  end
end
