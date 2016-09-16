namespace :db do
  desc 'Populates databases from XML'
  task 'populate' => :environment do
    puts "Populating exploits"
    PopulateExploit.populate_exploits_from_exploit_db
    puts "Populating CVE items"
    CveDatabase.populate_data_from_csv_xml("./allitems.xml")
    puts "Populating CWE items"
    CweWeaknessCatalog.populate_data_from_cwe_xml("./cwec_v2.9.xml")
  end
end
