module Penetrations
  def generate(helper, opts, screenshots)
    @helper = helper
    @screenshots = screenshots

    @penetrations = opts[:penetrations]
    recipe
  end

  def recipe
    @helper.full_page_section(self, "Penetration")
    move_down 20

    @penetrations.each do |id, penetration|
      start_new_page
      @helper.subsection(self, penetration[:vulnerability])
      @helper.text(self, "<b>Vulnerability Exploited:</b> #{penetration[:vulnerability]}", inline_format: true)
      move_down 20

      @helper.text(self, "<b>System Vulnerable:</b> #{penetration[:system_vulnerable]}", inline_format: true)
      move_down 20

      text "<b>Vulnerability Explanation:</b>", inline_format: true
      @helper.text(self, "#{penetration[:vulnerability_explanation]}",  indent_paragraphs: 30)
      move_down 20

      text "<b>Vulnerability Fix:</b>", inline_format: true
      @helper.text(self, "#{penetration[:vulnerability_fix]}", indent_paragraphs: 30)
      move_down 20

      text "<b>Severity:</b> #{get_severity_text(penetration[:severity])}", inline_format: true
      move_down 20

      text "<b>Proof of Concept Code:</b>", inline_format: true
      move_down 20
      text penetration[:proof_of_concept_code].gsub!(" ", "#{Prawn::Text::NBSP}"), font_family: "Courier", size: 12

      @screenshots.where(vulnerability_id: id).each do |screenshot|
        # a screenshot.file is the object, which holds a #file property (the binary data),
        # which could be nil if someone curls a screenshot REST entity with no file
        if screenshot.file.file
          # we read in the actual file to a StringIO instance so it works
          # on both local and remote storage locations
          image StringIO.new(screenshot.file.read), fit: [450, 450]
          move_down 10
          @helper.text(self, screenshot.caption)
        end
      end

      move_down 20
    end
  end

  private

  def get_severity_text(current_severity)
    severities = {
      critical: "<color rgb='#{get_rgb_color(:pink)}'>CRITICAL</color>",
      high: "<color rgb='#{get_rgb_color(:red)}'>HIGH</color>",
      medium: "<color rgb='#{get_rgb_color(:orange)}'>MEDIUM</color>",
      low: "<color rgb='#{get_rgb_color(:yellow)}'>LOW</color>",
      note: "<color rgb='#{get_rgb_color(:green)}'>NOTE</color>"
    }
    severities[current_severity.to_sym]
  end

  def get_rgb_color(color)
    colors = {
      red: 'FF0000',
      pink: 'FFC0CB',
      orange: 'FF9F30',
      yellow: 'FFF700',
      green: '00FF00'
    }
    colors[color]
  end
end
