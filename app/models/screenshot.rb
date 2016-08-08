class Screenshot < ActiveRecord::Base
	mount_uploader :file, PictureUploader
  belongs_to :report
end
