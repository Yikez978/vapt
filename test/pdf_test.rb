require 'test_helper'

class PdfTest < ActiveSupport::TestCase
    test "generation" do
        report = Report.new
        pdf = report.generate!
        assert pdf.start_with? "%PDF"
    end
end
