class Evidence < ActiveRecord::Base
  has_ancestry
  
  has_attached_file :asset
  # Explicitly do not validate
  do_not_validate_attachment_file_type :asset
end
