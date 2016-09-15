desc 'Enables registration'
task :enable_registration do
  setting = Setting.find_by(name: "registration_active")
  setting.update! value: "1"
end

desc 'Disables registration'
task :disable_registration do
  setting = Setting.find_by(name: "registration_active")
  setting.update! value: "0"
end
