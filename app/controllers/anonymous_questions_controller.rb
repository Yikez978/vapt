class AnonymousQuestionsController < ApplicationController
  before_action :set_anonymous_question, only: [:show, :edit, :update, :destroy]
  before_action :ensure_admin

  # GET /anonymous_questions
  # GET /anonymous_questions.json
  def index
    @anonymous_questions = AnonymousQuestion.all
  end

  def printable
    return 403 unless current_user.admin?
    @anonymous_questions = AnonymousQuestion.where(active: true)
  end

  # GET /anonymous_questions/1
  # GET /anonymous_questions/1.json
  def show
  end

  # GET /anonymous_questions/new
  def new
    @anonymous_question = AnonymousQuestion.new
  end

  # GET /anonymous_questions/1/edit
  def edit
  end

  # POST /anonymous_questions
  # POST /anonymous_questions.json
  def create
    @anonymous_question = AnonymousQuestion.new(anonymous_question_params)

    respond_to do |format|
      if @anonymous_question.save
        format.html { redirect_to @anonymous_question, notice: 'Anonymous question was successfully created.' }
        format.json { render :show, status: :created, location: @anonymous_question }
      else
        format.html { render :new }
        format.json { render json: @anonymous_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /anonymous_questions/1
  # PATCH/PUT /anonymous_questions/1.json
  def update
    respond_to do |format|
      if @anonymous_question.update(anonymous_question_params)
        format.html { redirect_to @anonymous_question, notice: 'Anonymous question was successfully updated.' }
        format.json { render :show, status: :ok, location: @anonymous_question }
      else
        format.html { render :edit }
        format.json { render json: @anonymous_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /anonymous_questions/1
  # DELETE /anonymous_questions/1.json
  def destroy
    @anonymous_question.destroy
    respond_to do |format|
      format.html { redirect_to anonymous_questions_url, notice: 'Anonymous question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_anonymous_question
      @anonymous_question = AnonymousQuestion.find(params[:id])
    end

    def ensure_admin
      unless current_user && current_user.admin?
        flash[:warning] = 'Not authorized.'
        redirect_to root_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def anonymous_question_params
      params.require(:anonymous_question).permit(:question, :active)
    end
end
