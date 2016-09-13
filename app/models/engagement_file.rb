class EngagementFile < ActiveRecord::Base
  has_attached_file :asset
  # Explicitly do not validate
  do_not_validate_attachment_file_type :asset
  # validates_attachment_content_type :asset, content_type: /\Aimage/
end
