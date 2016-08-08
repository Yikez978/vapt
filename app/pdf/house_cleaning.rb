module HouseCleaning
  def generate(helper, opts)
    @helper = helper
    @house_cleaning_text = opts[:house_cleaning]
    recipe
  end

  def recipe
    @helper.section(self, "House Cleaning")
    move_down 20

    @helper.text(self, @house_cleaning_text)
  end

  private
end
