# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# General Category
Setting.find_or_create_by(label: "Competition Name:",
													name: "project_name", value: "VAPT", setting_type: "text", category: "General")
Setting.find_or_create_by(label: "Competition Start Time:",
													name: "start_time", value: DateTime.current.strftime("%m/%d/%Y %I:%M %p"), setting_type: "date", category: "General")
Setting.find_or_create_by(label: "Competition End Time:",
													name: "end_time", value: (DateTime.current + 1.days).strftime("%m/%d/%Y %I:%M %p"), setting_type: "date", category: "General")
Setting.find_or_create_by(label: "Max number of members per team:",
													name: "max_members_per_team", value: "5", setting_type: "text", category: "General")
Setting.find_or_create_by(label: "Send activation e-mails?", tooltip: "Requires mailer config",
													name: "send_activation_emails", value: "1", setting_type: "boolean", category: "General")
Setting.find_or_create_by(label: "Allow users to view profiles other than their own?",
													name: "view_other_profiles", value: "1", setting_type: "boolean", category: "General")


user = User.new(id: Random.rand(10000),fname:  "admin",lname: "user",username: "admin",admin: true)
user.password = "password"
user.password_confirmation = "password"
user.save


EngagementType.find_or_create_by(name: "Reaccuring")
EngagementType.find_or_create_by(name: "Top 100")
EngagementType.find_or_create_by(name: "Accreditation")
