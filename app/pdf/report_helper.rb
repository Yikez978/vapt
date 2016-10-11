class ReportHelper
  attr_accessor :section_number

  def initialize
    @section_number = 0
    @subsection_number = 0
  end

  def full_page_section(pdf, content)
      pdf.start_new_page
      @section_number += 1
      @subsection_number = 0
      pdf.move_down 200
      pdf.text "<u>#{section_subsection} #{content}</u>", size: 36, align: :center, inline_format: true
  end

  def section(pdf, content)
      pdf.start_new_page
      @section_number += 1
      @subsection_number = 0
      pdf.text "<u>#{section_subsection} #{content}</u>", size: 20, inline_format: true
  end

  def subsection(pdf, content)
    pdf.move_down 20
    @subsection_number += 1
    pdf.text "#{section_subsection} #{content}", size: 16
    pdf.move_down 20
  end

  def text(pdf, content, opts = {})
    content.each_line do |line|
      if line.strip.start_with?('<ul>', '</ul>')
        # nop, we don't want those lines, just triggering we're in a list
      elsif line.strip.start_with? '<li>'
        line.gsub!('<li>', '')
        line.gsub!('</li>', '')
        bullet_item(pdf, line, opts)
      else
        # set default indentation for paragraphs
        opts[:indent_paragraphs] = opts[:indent_paragraphs] || opts[:indent_paragraphs] = 30
      end
    end
  end

  private

  def bullet_item(pdf, string, opts = {}, level = 1)
    pdf.indent (15 * level), 0 do
      pdf.text "• " + string, opts
    end
  end

  def section_subsection
    "#{@section_number}.#{@subsection_number}"
  end
end
