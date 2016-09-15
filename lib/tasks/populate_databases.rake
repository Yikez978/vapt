namespace :db do
  desc 'Populates databases from XML'
  task 'populate' => :environment do
    PopulateExploit.populate_exploits_from_exploit_db
    CveDatabase.populate_data_from_csv_xml("./allitems.xml")
    CweWeaknessCatalog.populate_data_from_cwe_xml("./cwec_v2.9.xml")
  end
end
