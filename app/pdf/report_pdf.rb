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
      @pdf.extend(RiskRating).generate(@helper, @opts) #
      @pdf.extend(Penetrations).generate(@helper, @opts, @screenshots)
        # vulnerability
        # system_vulnerable
        # vulnerability_explanation
        # vulnerability_fix
        # severity: :critical
        # proof_of_concept_code
      @pdf.extend(PostExploitation).generate(@helper, @opts) #post_exploitation
      @pdf.extend(HouseCleaning).generate(@helper, @opts) #house_cleaning
      @pdf.extend(AdditionalItems).generate(@helper, @opts) #additional_items
      @pdf.extend(PageNumbers).generate

      @pdf.render
    end
end
