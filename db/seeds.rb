# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# General Category
Setting.find_or_create_by(label: "Competition Name:",
													name: "competition_name", value: "HackTheArch", setting_type: "text", category: "General")
Setting.find_or_create_by(label: "Competition Start Time:",
													name: "start_time", value: DateTime.current.strftime("%m/%d/%Y %I:%M %p"), setting_type: "date", category: "General")
Setting.find_or_create_by(label: "Competition End Time:",
													name: "end_time", value: (DateTime.current + 1.days).strftime("%m/%d/%Y %I:%M %p"), setting_type: "date", category: "General")
Setting.find_or_create_by(label: "Max number of members per team:",
													name: "max_members_per_team", value: "5", setting_type: "text", category: "General")
Setting.find_or_create_by(label: "Send activation e-mails?", tooltip: "Requires mailer config",
													name: "send_activation_emails", value: "1", setting_type: "boolean", category: "General")
Setting.find_or_create_by(label: "Use bracket based handicap system?",
													name: "use_bracket_handicaps", value: "0", setting_type: "boolean", category: "General")
Setting.find_or_create_by(label: "Allow users to view profiles other than their own?",
													name: "view_other_profiles", value: "1", setting_type: "boolean", category: "General")

# Scoring Category
Setting.find_or_create_by(label: "Subtract hint deductions before problem is solved?",
													name: "subtract_hint_points_before_solve", value: "1", setting_type: "boolean", category: "Scoring")
Setting.find_or_create_by(label: "Scoreboard (on/off):",
													name: "scoreboard_on", value: "1", setting_type: "boolean", category: "Scoring")
Setting.find_or_create_by(label: "Maximum number of submissions per team:", tooltip: "0 means no limit",
													name: "max_submissions_per_team", value: "0", setting_type: "text", category: "Scoring")

# Payment Category
Setting.find_or_create_by(label: "Require Payment?", tooltip: "Reqires 'stripe' configuration",
													name: "require_payment", value: "0", setting_type: "boolean", category: "Payment")
Setting.find_or_create_by(label: "Entry cost:", tooltip: "in $0.01 increments (e.g., 500 = $5.00 USD)",
													name: "entry_cost", value: "500", setting_type: "text", category: "Payment")
Setting.find_or_create_by(label: "50% Off Discount Code:", tooltip: "empty string disables",
													name: "fifty_percent_off", value: "", setting_type: "text", category: "Payment")
Setting.find_or_create_by(label: "100% Off Discount Code:", tooltip: "empty string disables",
													name: "one_hundred_percent_off", value: "", setting_type: "text", category: "Payment")

bracket = Bracket.find_or_create_by(name: "Professional", priority: "10", hints_available: 0)
Bracket.find_or_create_by(name: "College", priority: "5", hints_available: 2)
Bracket.find_or_create_by(name: "High School", priority: "1", hints_available: 4)

team = Team.find_or_create_by(name:  "admins",
															passphrase: "password",
															bracket_id: bracket.id)

user = User.new(id: Random.rand(10000),fname:  "admin",lname: "user",username: "admin",admin: true,activated: true,paid: true,team_id: team.id,activated_at: Time.zone.now)
user.password = "password"
user.password_confirmation = "password"
user.save

user.join_team(team)

hint = Hint.find_or_create_by(hint: "The test was named after him",
															points: "25",
															priority: "1")

problem = Problem.find_or_create_by(name: "Who's that scientist?",
																		points: "100",
																		category: "Trivia",
																		description: "What's the name of the scientist that invented the test to determine the ability of a machine to exhibit intelligent behavior equivalent to, or indistinguishable from, that of a human?",
																		solution: "Alan Turing",
																		correct_message: "Very good!",
																		false_message: "Try again!",
																		solution_case_sensitive: "1",
																		visible: "1")
problem.add(hint.id)

Problem.find_or_create_by(name: "Google Foo",
													points: "100",
													category: "Network Exploitation",
													description: "What is the name of the site that indexes varios IoT devices like web cams and ethernet enabled thermostats?",
													solution: "Shodan",
													correct_message: "Scary, right!?",
													false_message: "Try again!",
													solution_case_sensitive: "1",
													visible: "1")

EngagementType.find_or_create_by(name: "Reaccuring")
EngagementType.find_or_create_by(name: "Top 100")
EngagementType.find_or_create_by(name: "Accreditation")
