class EvidencesController < ApplicationController
  
  protect_from_forgery with: :exception, except: [:list, :create_folder, :upload, :remove, :download, :rename]
  
  before_action :logged_in_user
  
  before_action :find_engagment_main
  
  respond_to :json
  
  # POST   /engagements/:engagement_id/hosts/:host_id/evidences/list(.:format)              evidences#list
  def list
    full_path = params[:path]
    
    if full_path == '/'
      @evidences = Evidence.roots.where(engagement_id: @engagement.id, engagement_main_id: @main.id)
    else
      parent_evidence = Evidence.find_by(engagement_id: @engagement.id, engagement_main_id: @main.id, full_path: full_path)
      @evidences = parent_evidence.children
    end
  end
  
  # POST   /engagements/:engagement_id/hosts/:host_id/evidences/upload(.:format)            evidences#upload
  def upload
    destination = params[:destination]
    sub_folders = destination.split('/').reject { |c| c.empty? }
    leaf_dir_name = (destination.split('/').reject { |c| c.empty? }).last
    
    params_keys = params.keys
    file_keys = params_keys.select{ |i| i[/file-\d*/] }
    
    file_keys.each do |file_key|
      file = params["#{file_key}"]
      filename = params["#{file_key}"].original_filename
      file_full_path = (destination == '/') ? "/#{filename}" : "#{destination}/#{filename}"
      
      parent_evidence = Evidence.find_by(full_path: destination, dir_type: 'dir')
      if parent_evidence
        parent_evidence.children.create(engagement_id: @engagement.id, engagement_main_id: @main.id, name: filename, asset: file, dir_type: "file", date: Time.now, full_path: file_full_path)
      else
        Evidence.create(engagement_id: @engagement.id, engagement_main_id: @main.id, name: filename, asset: file, dir_type: "file", date: Time.now, full_path: file_full_path)
      end
    end
    
    render json: { result: { success: true, error: nil } }
  end
  
  # POST   /engagements/:engagement_id/hosts/:host_id/evidences/rename(.:format)            evidences#rename
  def rename
  end
  
  # POST   /engagements/:engagement_id/hosts/:host_id/evidences/copy(.:format)              evidences#copy
  def copy
  end
  
  # POST   /engagements/:engagement_id/hosts/:host_id/evidences/move(.:format)              evidences#move
  def move
  end
  
  # POST   /engagements/:engagement_id/hosts/:host_id/evidences/remove(.:format)            evidences#remove
  def remove
    params[:items].each do |item_path|
      evidence = Evidence.find_by(full_path: item_path)
      evidence.destroy
    end
    
    render json: { result: { success: true, error: nil } }
  end
  
  # POST   /engagements/:engagement_id/hosts/:host_id/evidences/edit(.:format)              evidences#edit
  def edit
  end
  
  # POST   /engagements/:engagement_id/hosts/:host_id/evidences/get_content(.:format)       evidences#get_content
  def get_content
  end
  
  # POST   /engagements/:engagement_id/hosts/:host_id/evidences/create_folder(.:format)     evidences#create_folder
  def create_folder
    new_path = params[:newPath]
    sub_folders = new_path.split('/').reject { |c| c.empty? }
    leaf_dir_name = (new_path.split('/').reject { |c| c.empty? }).last
    
    if sub_folders.size == 1
      Evidence.create(engagement_id: @engagement.id, engagement_main_id: @main.id, name: sub_folders.first, dir_type: "dir", date: Time.now, full_path: new_path)
    else
      last_parent_folders = sub_folders
      last_parent_folders.pop # remove last element from array
      parent_evidence = Evidence.find_by(full_path: (last_parent_folders.size == 1) ? "/#{last_parent_folders.first}" : "/#{last_parent_folders.join('/')}")
      parent_evidence.children.create(engagement_id: @engagement.id, engagement_main_id: @main.id, name: leaf_dir_name, dir_type: "dir", date: Time.now, full_path: new_path)
    end
    
    render json: { result: { success: true, error: nil } }
  end
  
  # POST   /engagements/:engagement_id/hosts/:host_id/evidences/download(.:format)          evidences#download
  def download
    action = params[:action]
    download_path = params[:path]
    
    evidence = Evidence.find_by(full_path: download_path)
    
    send_file evidence.asset.path
  end
  
  # POST   /engagements/:engagement_id/hosts/:host_id/evidences/download_multiple(.:format) evidences#download_multiple
  def download_multiple
    params[:items].each do |item_path|
      evidence = Evidence.find_by(full_path: item_path)
      send_file evidence.asset.path
    end
  end
  
  # POST   /engagements/:engagement_id/hosts/:host_id/evidences/compress(.:format)          evidences#compress
  def compress
  end
  
  # POST   /engagements/:engagement_id/hosts/:host_id/evidences/extract(.:format)           evidences#extract
  def extract
  end
  
  # POST   /engagements/:engagement_id/hosts/:host_id/evidences/permissions(.:format)       evidences#permissions
  def permissions
  end
  
  protected
  def find_engagment_main
    @engagement = Engagement.find(params[:engagement_id])
    @main = EngagementMain.find(params[:host_id])
  end
end
