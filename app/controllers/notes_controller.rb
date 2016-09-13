class NotesController < ApplicationController
	def create
		@notable = (eval params[:notable_type]).find(params[:notable_id])
		note = @notable.notes.create(title: params[:title], description: params[:note][:description], user_id: current_user.id)
		if note.save
			redirect_to request.referer
		end
	end

	def destroy
		@note = Note.find(params[:id])
		@note.destroy
		respond_to do |format|
			format.json {render json: {data: {}}}
		end
	end
end
