json.array!(@screenshots) do |screenshot|
  json.extract! screenshot, :id, :file, :report_id, :vulnerability_id
  json.url screenshot_url(screenshot, format: :json)
end
