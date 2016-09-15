class CweCompoundElementsController < ApplicationController
	def show
		@cwe_element = CweCompoundElement.find_by(element_id: params[:id])
	end
end
