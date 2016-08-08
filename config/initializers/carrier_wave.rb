if Rails.env.production?
	CarrierWave.configure do |config|
    # Configuration for Google Drive
	 	config.fog_credentials = {
   		provider:                         'Google',
   		google_storage_access_key_id:     'GOOGLE_ACCESS_KEY',
   		google_storage_secret_access_key: 'GOOGLE_SECRET_KEY'
  	}
   	config.fog_directory = 'GOOGLE_BUCKET'
  end
end
