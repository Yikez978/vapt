class CweCategoriesController < ApplicationController
	def show
		@cwe_cat = CweCategory.find_by(cwe_cat_id: params[:id])
	end
end
