class CvesController < ApplicationController
  # GET /cves/:id(.:format)
  def show
    @cve = CveDatabase.find_by(cve_database_id: params[:id])
    @cve_database_refs = @cve.cve_database_refs
    @cve_database_comments = @cve.cve_database_comments
    @cve_database_votes = @cve.cve_database_votes
  end

  def index
  	@cves = CveDatabase.all
  end
end
