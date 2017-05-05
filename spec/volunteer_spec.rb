require("spec_helper")

describe(Volunteer) do

  describe("#initialize") do
    it("is initialized with a name") do
      volunteer = Volunteer.new({:name => "Tommy Jones", :id => nil})
      expect(volunteer).to(be_an_instance_of(Volunteer))
    end

    it("can be initialized with its database ID") do
      volunteer = Volunteer.new({:name => "Tommy Jones", :id => 1})
      expect(volunteer).to(be_an_instance_of(Volunteer))
    end
  end

  describe(".all") do
    it("starts off with no project") do
      expect(Volunteer.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("returns a volunteer by its ID number") do
      test_volunteer = Volunteer.new({:name => "Tommy Jones", :id => nil})
      test_volunteer.save()
      test_volunteer2 = Volunteer.new({:name => "Marge Smith", :id => nil})
      test_volunteer2.save()
      expect(Volunteer.find(test_volunteer2.id())).to(eq(test_volunteer2))
    end
  end

  describe("#==") do
    it("is the same volunteer if it has the same name and id") do
      volunteer = Volunteer.new({:name => "Tommy Jones", :id => nil})
      volunteer2 = Volunteer.new({:name => "Tommy Jones", :id => nil})
      expect(volunteer).to(eq(volunteer2))
    end
  end

  describe("#update") do
    it("lets you update volunteers in the database") do
      volunteer = Volunteer.new({:name => "Tommy Jones", :id => nil})
      volunteer.save()
      volunteer.update({:name => "Thomas Jones"})
      expect(volunteer.name()).to(eq("Thomas Jones"))
    end
  end

  describe("#delete") do
    it("lets you delete a volunteer from the database") do
      volunteer = Volunteer.new({:name => "Tommy Jones", :id => nil})
      volunteer.save()
      volunteer2 = Volunteer.new({:name => "Marhe Smith", :id => nil})
      volunteer2.save()
      volunteer.delete()
      expect(Volunteer.all()).to(eq([volunteer2]))
    end
  end
end
