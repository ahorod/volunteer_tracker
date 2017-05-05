require("spec_helper")

describe(Project) do


  describe(".all") do
    it("starts off with no projects") do
      expect(Project.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("returns a project by its ID number") do
      test_project = Project.new({:name => "Liguria trails", :info => "Build trails in the forest", :id => nil})
      test_project.save()
      test_project2 = Project.new({:name => "Short Beach cleenup", :info => "Remove trash from the sand", :id => nil})
      test_project2.save()
      expect(Project.find(test_project2.id())).to(eq(test_project2))
    end
  end

  describe("#==") do
    it("is the same project if it has the same name and id") do
      project = Project.new({:name => "Liguria trails", :info => "Build trails in the forest", :id => nil})
      project2 = Project.new({:name => "Liguria trails", :info => "Build trails in the forest", :id => nil})
      expect(project).to(eq(project2))
    end
  end

  describe("#update") do
    it("lets you update projects in the database") do
      project = Project.new({:name => "Liguria trails", :info => "Build trails in the forest", :id => nil})
      project.save()
      project.update({:name => "Liguria trails lake Dolce"})
      expect(project.name()).to(eq("Liguria trails lake Dolce"))
    end
  end

  describe("#delete") do
    it("lets you delete a project from the database") do
      project = Project.new({:name => "Liguria trails", :info => "Build trails in the forest", :id => nil})
      project.save()
      project2 = Project.new({:name => "Short Beach cleenup", :info => "Build trails in the forest", :id => nil})
      project2.save()
      project.delete()
      expect(Project.all()).to(eq([project2]))
    end
  end
end
