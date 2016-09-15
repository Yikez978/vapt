module AdditionalItems
  def generate(helper, opts)
    @helper = helper
    @additional_items_text = opts[:additional_items]
    recipe
  end

  def recipe
    @helper.section(self, "Additional Items Not Mentioned in the Report")
    move_down 20
    @helper.text(self, @additional_items_text)
  end

  private
end
