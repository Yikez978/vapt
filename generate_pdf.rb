require 'pry'
require 'prawn'
require 'prawn/table'
require_relative './app/pdf/report_helper'
#require_relative './app/pdf/report'
Dir["/Users/jacobsmith/Code/hack-the-arch/app/pdf/*.rb"].each {|file| require file }

report = Report.new
report.set_options student_name: 'Jacob Smith'
report.generate!
