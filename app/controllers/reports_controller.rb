class ReportsController < ApplicationController
  before_action :logged_in_user
  before_action :set_report, only: [:show, :edit, :update, :destroy, :get_pdf, :new_penetration, :remove_penetration]

  # GET /reports
  # GET /reports.json
  def index
    if current_user.admin?
      @reports = Report.all
    else
      @reports = Report.where(user: current_user)
    end
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
    @report.options['penetrations'] = {}
    @report.options['penetrations'][SecureRandom.uuid] = {}


    vulnerability_ids = @report.options['penetrations'].keys
    @screenshots = Screenshot.where(vulnerability_id: vulnerability_ids)
    @report.user = current_user
    @report.save!
    redirect_to edit_report_path(@report)
  end

  def new_penetration
    respond_to do |format|
      @existing_penetration = {}
      @vulnerability_id = SecureRandom.uuid

      vulnerability_ids = @report.options['penetrations'].keys
      @screenshots = Screenshot.where(vulnerability_id: vulnerability_ids)

      format.js { render :new_penetration }
    end
  end

  def remove_penetration
    @report.options[:penetrations].delete(params[:penetration_id])
    @report.save!
    render nothing: true
  end

  # GET /reports/1/edit
  def edit
    vulnerability_ids = @report.options['penetrations'].keys
    @screenshots = Screenshot.where(vulnerability_id: vulnerability_ids)
    @engagement = @report.engagement
  end

  def get_pdf
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'New_Report', footer: {right: '[page]'}
      end
    end
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)
    @report.user = current_user

    respond_to do |format|
      if @report.save
        save_report_audit
        format.html { redirect_to reports_url, notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|

      attributes = report_params
      attributes[:customer] = Customer.find_or_initialize_by(name: attributes[:customer]) if attributes[:customer].present?
      if @report.update(attributes)
        save_report_audit
        format.html { redirect_to reports_url, notice: 'Report was successfully updated.' }
        format.pdf { render :show, status: :ok, location: @report }
      else
        format.html { render reports_url }
        format.pdf { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def save_report_audit
    report = ReportPdf.new
    report.set_options(@report.options)
    report.set_screenshots(Screenshot.where(report_id: @report.id))

    pdf = report.generate!
    timestamp = Time.now.strftime('%F_%T')

    report_name = !@report.options['report_name'].blank? ? @report.options['report_name'] : "untitled_report_#{timestamp}"

    save_path = Rails.root.join('pdfs',"#{current_user.fname}_#{current_user.lname}_#{current_user.id}", report_name)
    FileUtils.mkdir_p save_path

    file_name = "#{timestamp}_report.pdf"
    File.open(save_path.join(file_name), 'wb') do |file|
      file << pdf
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Report.find(params[:id])
    if @report.user != current_user
      redirect_to reports_path, notice: 'You do not have access to that report.'
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def report_params
    params.require(:report).permit!
  end
end