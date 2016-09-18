class ScreenshotsController < ApplicationController
  before_action :set_screenshot, only: [:show, :edit, :update, :destroy]
  before_action :ensure_report_and_vulnerability_present_for_new, only: :new

  # GET /screenshots/new
  def new
    @screenshot = Screenshot.new
  end

  # GET /screenshots/1/edit
  def edit
  end

  # POST /screenshots
  # POST /screenshots.json
  def create
    @screenshot = Screenshot.new(screenshot_params)

    respond_to do |format|
      if @screenshot.save
        format.html { render :close_window, notice: 'Screenshot was successfully created.' }
        format.json { render :show, status: :created, location: @screenshot }
      else
        format.html { render :new }
        format.json { render json: @screenshot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /screenshots/1
  # PATCH/PUT /screenshots/1.json
  def update
    respond_to do |format|
      if @screenshot.update(screenshot_params)
        format.html { redirect_to most_recent_report, notice: 'Screenshot was successfully updated.' }
        format.json { render :show, status: :ok, location: @screenshot }
      else
        format.html { render :edit }
        format.json { render json: @screenshot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /screenshots/1
  # DELETE /screenshots/1.json
  def destroy
    @screenshot.destroy
    respond_to do |format|
      format.html { redirect_to most_recent_report, notice: 'Screenshot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def most_recent_report
      report = Report.where(user_id: current_user).last

      if report
        edit_report_path(report)
      else
        reports_path
      end
    end

    def ensure_report_and_vulnerability_present_for_new
      if params[:vulnerability_id].blank?
        redirect_to most_recent_report, notice: 'Please be sure the report and vulnerability are present (click "Add Screenshot" while editing a report).'
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_screenshot
      @screenshot = Screenshot.find(params[:id])
      redirect_to most_recent_report if Report.find(@screenshot.report_id).user != current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def screenshot_params
      params.require(:screenshot).permit(:file, :report_id, :vulnerability_id, :index, :caption)
    end
end
