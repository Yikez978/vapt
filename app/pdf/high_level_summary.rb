module HighLevelSummary

  def generate(helper, opts)
    @helper = helper
    @high_level_summary_text = opts[:high_level_summary]
    @recommendations_text = opts[:recommendations]
    recipe
  end

  def recipe
    @helper.section(self, "High-Level Summary")
    move_down 20

    @helper.text(self, @high_level_summary_text)

    @helper.subsection(self, "Recommendations")
    @helper.text(self, @recommendations_text)
  end

  private
end
