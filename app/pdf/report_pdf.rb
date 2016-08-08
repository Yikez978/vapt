# modeled after http://www.yoniweisbrod.com/generating-complex-pdf-documents-in-rails-with-prawn/
class ReportPdf
    include Prawn::View

    attr_accessor :pdf, :opts

    def initialize
      @pdf = Prawn::Document.new
      @helper = ReportHelper.new
    end

    def set_options(opts)
      @opts = opts
    end

    def set_screenshots(screenshots)
      @screenshots = screenshots
    end

    def generate!
      @pdf.extend(CoverPage).generate(@opts) # student_name
      @pdf.extend(IntroObjectiveRequirements).generate(@helper, @opts) # introduction, objective, requirements
      @pdf.extend(HighLevelSummary).generate(@helper, @opts) # high_level_summary, recommendations
      @pdf.extend(Methodologies).generate(@helper, @opts) # methodologies_overview, information_gathering, service_enumeration, enumerations (of form: [ {server: '192...', tcp: '1, 2, 3', udp: '4, 5, 6'}, ...])
      @pdf.extend(Penetrations).generate(@helper, @opts, @screenshots)
        # vulnerability
        # system_vulnerable
        # vulnerability_explanation
        # vulnerability_fix
        # severity: :critical
        # proof_of_concept_code
      @pdf.extend(MaintainingAccess).generate(@helper, @opts) #maintaining_access
      @pdf.extend(HouseCleaning).generate(@helper, @opts) #house_cleaning
      @pdf.extend(AdditionalItems).generate(@helper, @opts) #additional_items
      @pdf.extend(PageNumbers).generate

      @pdf.render
    end
end
