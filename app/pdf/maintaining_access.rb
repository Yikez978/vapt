module MaintainingAccess

  def generate(helper, opts)
    @helper = helper
    @maintaining_access_text = opts[:maintaining_access]
    recipe
  end

  def recipe
    @helper.section(self, "Maintaining Access")
    move_down 20

    @helper.text(self, @maintaining_access_text)
  end

  private
end
