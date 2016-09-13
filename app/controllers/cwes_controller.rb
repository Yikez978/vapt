class CwesController < ApplicationController
	def show
		@cwe = CweWeakness.find_by(weakness_id: params[:id])
	end

	def index
		@cwes = CweWeakness.all
	end
end
