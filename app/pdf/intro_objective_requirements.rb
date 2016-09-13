module IntroObjectiveRequirements
  def generate(helper, options = {})
    @helper = helper
    @introduction_text = options[:introduction]
    @objective_text = options[:objective]
    @requirements_text = options[:requirements]
    recipe
  end

  def recipe
    @helper.section(self, "Lab and Exam Penetration Test Report")

    @helper.subsection(self, "Introduction")
    @helper.text(self, @introduction_text)

    @helper.subsection(self, "Objective")
    @helper.text(self, @objective_text)

    @helper.subsection(self, "Requirements")
    @helper.text(self, @requirements_text)
  end

  private
end
