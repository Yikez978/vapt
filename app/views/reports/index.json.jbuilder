json.array!(@reports) do |report|
  json.extract! report, :id, :options
  json.url report_url(report, format: :json)
end
