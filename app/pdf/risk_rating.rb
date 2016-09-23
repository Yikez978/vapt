module RiskRating

  def generate(helper, opts)
    @helper = helper
    @risk_rating_text = opts[:risk_rating]
    @information_gathering_text = opts[:information_gathering]
    recipe
  end

  def recipe
    @helper.section(self, 'Risk Rating')
    move_down 20
    @helper.text(self, @risk_rating_text)

    @helper.subsection(self, 'Information Gathering')
    @helper.text(self, @information_gathering_text)
  end

  private
end


