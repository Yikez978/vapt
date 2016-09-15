class QuestionnaireResponsesController < ApplicationController
  def new
    @questionnaire_response = QuestionnaireResponse.new
    @anonymous_questions = AnonymousQuestion.where(active: true)
  end

  def create
    params[:questionnaire_response][:anonymous_question].each do |id, obj|
      AnonymousResponse.create!(anonymous_question_id: id, value: obj[:response])
    end

    flash[:success] = "Successfully submitted your anonymous questionnaire."
    redirect_to root_path
  end

  private

  def questionnaire_response_params
    params.require(:questionnaire_response).permit({ anonymous_response: [:anonymous_question_id, :response]})
  end
end
