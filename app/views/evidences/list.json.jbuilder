json.set! :result do
	json.array! @evidences do |evidence|
	  json.name evidence.name
		json.rights ''
		json.size evidence.asset_file_size
		json.date evidence.date
		json.type evidence.dir_type
	end
end