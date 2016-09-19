# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160919170723) do

  create_table "caches", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "key"
    t.string   "value"
    t.boolean  "cache_valid"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "code_blocks", force: :cascade do |t|
    t.text     "code_block"
    t.string   "code_example_lang"
    t.text     "desc"
    t.string   "cwe_demonstrative_example_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "block_nature"
  end

  create_table "custom_findings", force: :cascade do |t|
    t.string   "host"
    t.string   "port"
    t.string   "service"
    t.integer  "severity"
    t.text     "desc"
    t.string   "level_of_access"
    t.integer  "engagement_main_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cve_database_comments", force: :cascade do |t|
    t.integer  "cve_database_id"
    t.string   "voter"
    t.text     "comment"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "cve_database_refs", force: :cascade do |t|
    t.integer  "cve_database_id"
    t.text     "ref"
    t.string   "source"
    t.text     "url"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "cve_database_votes", force: :cascade do |t|
    t.integer  "cve_database_id"
    t.string   "count"
    t.text     "vote"
    t.string   "vote_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "cve_databases", force: :cascade do |t|
    t.string   "cve_database_id"
    t.string   "status"
    t.string   "phase"
    t.string   "phase_date"
    t.text     "desc"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "cwe_alternate_terms", force: :cascade do |t|
    t.string   "term"
    t.text     "desc"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "alternate_termable_id"
    t.string   "alternate_termable_type"
  end

  create_table "cwe_architechtural_paradigms", force: :cascade do |t|
    t.string   "prevalence"
    t.string   "name"
    t.integer  "paradigmable_id"
    t.string   "paradigmable_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "cwe_audiences", force: :cascade do |t|
    t.string   "stakeholder"
    t.text     "stakeholder_desc"
    t.integer  "cwe_view_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "cwe_categories", force: :cascade do |t|
    t.integer  "cwe_cat_id"
    t.string   "name"
    t.string   "cat_status"
    t.text     "desc"
    t.integer  "cwe_weakness_catalog_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.text     "extended_desc"
    t.string   "liklihood_of_exploits"
    t.string   "affected_resource"
  end

  create_table "cwe_common_consequences", force: :cascade do |t|
    t.string   "consequence_scope"
    t.string   "technical_impact"
    t.text     "note"
    t.integer  "consequencable_id"
    t.string   "consequencable_type"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "cwe_compound_elements", force: :cascade do |t|
    t.integer  "element_id"
    t.string   "name"
    t.string   "compound_element_abstraction"
    t.string   "compound_element_structure"
    t.string   "element_status"
    t.text     "desc_summary"
    t.text     "ext_desc"
    t.integer  "cwe_weakness_catalog_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "likelihood_of_exploit"
    t.text     "other_notes"
    t.string   "affected_resource"
    t.string   "casual_nature"
    t.string   "relevant_property"
  end

  create_table "cwe_content_histories", force: :cascade do |t|
    t.integer  "contentable_id"
    t.string   "contentable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "cwe_demonstrative_examples", force: :cascade do |t|
    t.string   "dx_id"
    t.text     "intro_text"
    t.integer  "demo_example_id"
    t.string   "demo_example_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "cwe_detection_methods", force: :cascade do |t|
    t.string   "method_name"
    t.text     "method_desc"
    t.string   "method_effectiveness"
    t.integer  "detectable_id"
    t.string   "detectable_type"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "method_id"
  end

  create_table "cwe_functional_areas", force: :cascade do |t|
    t.string   "functional_area"
    t.integer  "functionable_id"
    t.string   "functionable_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "cwe_languages", force: :cascade do |t|
    t.string   "language_name"
    t.string   "language_class"
    t.integer  "language_id"
    t.string   "language_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.text     "note"
  end

  create_table "cwe_maintenance_notes", force: :cascade do |t|
    t.text     "note"
    t.integer  "maintenable_id"
    t.string   "maintenable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "image_location"
    t.string   "image_title"
  end

  create_table "cwe_mitigations", force: :cascade do |t|
    t.string   "mitigation_id"
    t.string   "mitigation_phase"
    t.string   "mitigation_strategy"
    t.text     "desc"
    t.integer  "mitigatable_id"
    t.string   "mitigatable_type"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "cwe_mode_of_intros", force: :cascade do |t|
    t.text     "mode_of_intro"
    t.integer  "mode_introable_id"
    t.string   "mode_introable_type"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "cwe_modifications", force: :cascade do |t|
    t.string   "modification_source"
    t.string   "modifier"
    t.string   "modifier_org"
    t.date     "modification_date"
    t.text     "modification_comment"
    t.integer  "cwe_content_history_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "cwe_observed_examples", force: :cascade do |t|
    t.string   "observed_example_ref"
    t.text     "desc"
    t.integer  "observable_id"
    t.string   "observable_type"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "cwe_prev_entry_names", force: :cascade do |t|
    t.date     "name_change_date"
    t.string   "value"
    t.integer  "cwe_content_history_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "cwe_references", force: :cascade do |t|
    t.string   "ref_id"
    t.text     "ref_author"
    t.string   "ref_title"
    t.string   "ref_section"
    t.string   "ref_edition"
    t.string   "ref_publisher"
    t.date     "ref_pubdate"
    t.date     "ref_date"
    t.string   "ref_link"
    t.integer  "referable_id"
    t.string   "referable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "local_ref_id"
  end

  create_table "cwe_related_attack_patterns", force: :cascade do |t|
    t.string   "capec_version"
    t.string   "capec_id"
    t.integer  "attackable_id"
    t.string   "attackable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "cwe_relationship_notes", force: :cascade do |t|
    t.text     "note"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "relationship_notable_id"
    t.string   "relationship_notable_type"
  end

  create_table "cwe_relationships", force: :cascade do |t|
    t.integer  "relationship_view_id"
    t.string   "ordinal"
    t.string   "target_form"
    t.string   "nature"
    t.integer  "target_id"
    t.integer  "relation_id"
    t.string   "relation_type"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "comment"
  end

  create_table "cwe_research_gaps", force: :cascade do |t|
    t.text     "research_gap"
    t.integer  "research_gapable_id"
    t.string   "research_gapable_type"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "cwe_submissions", force: :cascade do |t|
    t.string   "submission_source"
    t.string   "submitter"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "cwe_content_history_id"
    t.date     "submission_date"
  end

  create_table "cwe_taxonomies", force: :cascade do |t|
    t.string   "mapped_taxonomy_name"
    t.string   "mapped_node_id"
    t.string   "mapped_node_name"
    t.string   "mapping_fit"
    t.integer  "taxonomy_id"
    t.string   "taxonomy_type"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "cwe_technology_classes", force: :cascade do |t|
    t.string   "prevalence"
    t.string   "name"
    t.integer  "technology_classable_id"
    t.string   "technology_classable_type"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "cwe_theoritical_notes", force: :cascade do |t|
    t.text     "note"
    t.integer  "theory_notable_id"
    t.string   "theory_notable_type"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "cwe_time_of_intros", force: :cascade do |t|
    t.text     "intro_phase"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "introable_id"
    t.string   "introable_type"
  end

  create_table "cwe_views", force: :cascade do |t|
    t.string   "name"
    t.string   "view_structure"
    t.string   "view_filter"
    t.integer  "cwe_weakness_catalog_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "view_status"
    t.integer  "view_id"
    t.text     "view_objective"
  end

  create_table "cwe_weakness_catalogs", force: :cascade do |t|
    t.string   "catalog_name"
    t.string   "catalog_version"
    t.date     "catalog_date"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "cwe_weakness_ordinalities", force: :cascade do |t|
    t.string   "ordinality"
    t.integer  "ordinalable_id"
    t.string   "ordinalable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "cwe_weaknesses", force: :cascade do |t|
    t.string   "weakness_id"
    t.string   "name"
    t.string   "weakness_abstruction"
    t.string   "weakness_status"
    t.text     "desc_summary"
    t.text     "ext_desc"
    t.integer  "cwe_weakness_catalog_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.text     "terminology_note"
    t.string   "liklihood_of_exploit"
    t.text     "background_details"
    t.string   "casual_nature"
    t.string   "affected_resource"
    t.text     "other_notes"
  end

  create_table "cwe_white_box_defs", force: :cascade do |t|
    t.text     "definition_block"
    t.integer  "box_defiable_id"
    t.string   "box_defiable_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "engagement_creds", force: :cascade do |t|
    t.string   "ip"
    t.text     "pwdump"
    t.string   "password"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "engagement_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "engagement_files", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "engagement_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
  end

  create_table "engagement_main_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "engagement_main_id"
  end

  create_table "engagement_mains", force: :cascade do |t|
    t.string   "host"
    t.text     "ports"
    t.string   "services"
    t.string   "vulns"
    t.string   "host_name"
    t.string   "os"
    t.integer  "user_id"
    t.integer  "engagement_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "aasm_state"
    t.string   "mac"
  end

  create_table "engagement_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "engagements", force: :cascade do |t|
    t.string   "engagement_name"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.text     "note"
    t.date     "note_add_date"
    t.integer  "engagement_type_id"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "is_site_wide_engagement", default: false
    t.string   "aasm_state"
    t.integer  "user_id"
    t.string   "ancestry"
    t.integer  "customer_id"
  end

  add_index "engagements", ["ancestry"], name: "index_engagements_on_ancestry"
  add_index "engagements", ["customer_id"], name: "index_engagements_on_customer_id"

  create_table "evidences", force: :cascade do |t|
    t.string   "name"
    t.string   "rights"
    t.string   "size"
    t.string   "date"
    t.string   "dir_type"
    t.string   "ancestry"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.integer  "engagement_id"
    t.integer  "engagement_main_id"
    t.string   "full_path"
  end

  create_table "exploit_platforms", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exploit_types", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exploits", force: :cascade do |t|
    t.integer  "exploit_platform_id"
    t.integer  "exploit_type_id"
    t.integer  "exploit_db_id"
    t.string   "file"
    t.text     "description"
    t.string   "date"
    t.string   "author"
    t.string   "port"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "source"
    t.integer  "user_id"
    t.boolean  "is_verified",              default: false
    t.string   "custom_file_file_name"
    t.string   "custom_file_content_type"
    t.integer  "custom_file_file_size"
    t.datetime "custom_file_updated_at"
  end

  create_table "host_creds", force: :cascade do |t|
    t.string   "ip"
    t.text     "pwdump"
    t.string   "password"
    t.text     "description"
    t.integer  "engagement_main_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "host_infos", force: :cascade do |t|
    t.string   "ip"
    t.string   "mac"
    t.string   "host_name"
    t.string   "os"
    t.string   "service_port"
    t.string   "service_protocol"
    t.string   "service_name"
    t.string   "service_banner"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "engagement_main_id"
    t.string   "service_status"
  end

  create_table "host_vulns", force: :cascade do |t|
    t.integer  "port"
    t.integer  "severity"
    t.string   "aasm_state"
    t.string   "cve"
    t.string   "cwe"
    t.string   "level_of_access"
    t.integer  "engagement_main_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.text     "synopsis"
    t.string   "vuln_name"
  end

  create_table "hosts", force: :cascade do |t|
    t.string   "name"
    t.string   "mac"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "engagement_id"
  end

  create_table "ips", force: :cascade do |t|
    t.string   "ip"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "engagement_id"
    t.integer  "sub_engagement_id"
  end

  create_table "metasploit_credential_cores", force: :cascade do |t|
    t.integer  "core_id"
    t.integer  "origin_id"
    t.string   "origin_type"
    t.integer  "private_id"
    t.integer  "public_id"
    t.string   "realm_id"
    t.integer  "workspace_id"
    t.datetime "metasploit_created_at"
    t.datetime "metasploit_updated_at"
    t.integer  "logins_count"
    t.integer  "metasploit_report_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "metasploit_credential_logins", force: :cascade do |t|
    t.integer  "login_id"
    t.integer  "core_id"
    t.integer  "service_id"
    t.string   "access_level"
    t.string   "status"
    t.datetime "last_attempted_at"
    t.datetime "metasploit_created_at"
    t.datetime "metasploit_updated_at"
    t.integer  "metasploit_report_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "metasploit_credential_origins", force: :cascade do |t|
    t.integer  "origin_id"
    t.integer  "service_id"
    t.string   "module_full_name"
    t.datetime "metasploit_created_at"
    t.datetime "metasploit_updated_at"
    t.integer  "metasploit_report_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "metasploit_credential_privates", force: :cascade do |t|
    t.integer  "private_id"
    t.string   "private_type"
    t.text     "data"
    t.datetime "metasploit_created_at"
    t.datetime "metasploit_updated_at"
    t.integer  "metasploit_report_id"
    t.string   "jtr_format"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "metasploit_credential_publics", force: :cascade do |t|
    t.integer  "public_id"
    t.string   "username"
    t.datetime "metasploit_created_at"
    t.datetime "metasploit_updated_at"
    t.integer  "metasploit_report_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "metasploit_events", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "workspace_id"
    t.integer  "host_id"
    t.datetime "metasploit_created_at"
    t.string   "name"
    t.datetime "metasploit_updated_at"
    t.string   "critical"
    t.string   "seen"
    t.string   "username"
    t.text     "info"
    t.string   "module_rhost"
    t.string   "module_name"
    t.integer  "metasploit_report_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "metasploit_exploit_attempts", force: :cascade do |t|
    t.integer  "exploit_attempt_id"
    t.integer  "service_id"
    t.integer  "vuln_id"
    t.datetime "attempted_at"
    t.string   "exploited"
    t.string   "fail_reason"
    t.string   "username"
    t.string   "module"
    t.string   "session_id"
    t.string   "loot_id"
    t.integer  "port"
    t.string   "proto"
    t.string   "fail_detail"
    t.integer  "metasploit_host_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "metasploit_host_notes", force: :cascade do |t|
    t.integer  "note_id"
    t.datetime "metasploit_created_at"
    t.datetime "metasploit_updated_at"
    t.string   "ntype"
    t.integer  "workspace_id"
    t.integer  "service_id"
    t.string   "critical"
    t.string   "seen"
    t.string   "vuln_id"
    t.text     "data"
    t.integer  "metasploit_host_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "metasploit_host_services", force: :cascade do |t|
    t.integer  "service_id"
    t.integer  "metasploit_host_id"
    t.datetime "metasploit_created_at"
    t.datetime "metasploit_updated_at"
    t.integer  "port"
    t.string   "proto"
    t.string   "state"
    t.string   "name"
    t.text     "info"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "metasploit_host_vulns", force: :cascade do |t|
    t.integer  "vuln_id"
    t.integer  "service_id"
    t.datetime "metasploit_created_at"
    t.datetime "metasploit_updated_at"
    t.string   "name"
    t.text     "info"
    t.string   "exploited_at"
    t.integer  "vuln_detail_count"
    t.integer  "vuln_attempt_count"
    t.string   "nexpose_data_vuln_def_id"
    t.string   "origin_id"
    t.string   "origin_type"
    t.text     "notes"
    t.text     "vuln_details"
    t.text     "vuln_attempts"
    t.integer  "metasploit_host_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "metasploit__ref_id"
  end

  create_table "metasploit_hosts", force: :cascade do |t|
    t.string   "metasploit_created_at"
    t.string   "address"
    t.string   "mac"
    t.string   "comm"
    t.string   "name"
    t.string   "state"
    t.string   "os_name"
    t.string   "os_flavor"
    t.string   "os_sp"
    t.string   "os_lang"
    t.string   "arch"
    t.string   "workspace_id"
    t.datetime "metasploit_updated_at", null: false
    t.string   "purpose"
    t.string   "info"
    t.string   "metasploit_scope"
    t.string   "note_count"
    t.string   "vuln_count"
    t.string   "service_count"
    t.string   "host_detail_count"
    t.string   "exploit_attempt_count"
    t.string   "cred_count"
    t.string   "history_count"
    t.string   "detected_arch"
    t.integer  "metasploit_report_id"
    t.datetime "created_at",            null: false
    t.text     "comments"
    t.string   "virtual_host"
    t.integer  "metasploit_id"
  end

  create_table "metasploit_module_arches", force: :cascade do |t|
    t.integer  "module_archs_id"
    t.string   "name"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "metasploit_module_detail_id"
  end

  create_table "metasploit_module_authors", force: :cascade do |t|
    t.integer  "author_id"
    t.integer  "metasploit_module_detail_id"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "metasploit_module_details", force: :cascade do |t|
    t.integer  "module_id"
    t.datetime "mtime"
    t.string   "file"
    t.string   "mtype"
    t.string   "refname"
    t.string   "fullname"
    t.string   "name"
    t.integer  "rank"
    t.text     "description"
    t.string   "license"
    t.string   "privileged"
    t.datetime "disclosure_date"
    t.string   "default_target"
    t.string   "default_action"
    t.string   "stance"
    t.string   "ready"
    t.integer  "metasploit_report_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "metasploit_module_platforms", force: :cascade do |t|
    t.integer  "module_platform_id"
    t.string   "name"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "metasploit_module_detail_id"
  end

  create_table "metasploit_module_refs", force: :cascade do |t|
    t.integer  "module_ref_id"
    t.string   "name"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "metasploit_module_detail_id"
  end

  create_table "metasploit_module_targets", force: :cascade do |t|
    t.integer  "module_target_id"
    t.string   "name"
    t.integer  "metasploit_index"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "metasploit_module_detail_id"
  end

  create_table "metasploit_refs", force: :cascade do |t|
    t.string   "ref"
    t.integer  "metasploit_host_vuln_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "metasploit_reports", force: :cascade do |t|
    t.string   "path"
    t.string   "time"
    t.string   "metasploit_user"
    t.string   "project"
    t.string   "product"
    t.integer  "user_id"
    t.integer  "engagement_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "is_completed",    default: false
  end

  create_table "metasploit_services", force: :cascade do |t|
    t.integer  "service_id"
    t.integer  "host_id"
    t.datetime "metasploit_created_at"
    t.datetime "metasploit_updated_at"
    t.integer  "port"
    t.string   "proto"
    t.string   "state"
    t.string   "name"
    t.text     "info"
    t.integer  "metasploit_report_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "nmap_cpes", force: :cascade do |t|
    t.integer  "nmap_port_id"
    t.string   "part"
    t.string   "vendor"
    t.string   "product"
    t.string   "version"
    t.string   "cpe_update"
    t.string   "edition"
    t.string   "language"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "nmap_host_ipidsequences", force: :cascade do |t|
    t.integer  "nmap_host_id"
    t.text     "values"
    t.text     "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "nmap_host_tcpsequences", force: :cascade do |t|
    t.integer  "nmap_host_id"
    t.string   "index"
    t.text     "difficulty"
    t.text     "values"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "nmap_host_tcptssequences", force: :cascade do |t|
    t.integer  "nmap_host_id"
    t.text     "values"
    t.text     "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "nmap_host_traceroutes", force: :cascade do |t|
    t.integer  "nmap_host_id"
    t.string   "port"
    t.string   "protocol"
    t.string   "ttl"
    t.string   "ipaddr"
    t.string   "rtt"
    t.text     "host"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "nmap_host_uptimes", force: :cascade do |t|
    t.integer  "nmap_host_id"
    t.string   "seconds"
    t.string   "last_boot"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "nmap_hostnames", force: :cascade do |t|
    t.integer  "nmap_host_id"
    t.string   "host_type"
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "nmap_hosts", force: :cascade do |t|
    t.integer  "nmap_report_id"
    t.string   "ip"
    t.string   "ipv4"
    t.string   "ipv6"
    t.string   "address"
    t.string   "mac"
    t.string   "vendor"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "nmap_operating_systems", force: :cascade do |t|
    t.integer  "nmap_host_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "nmap_os_classes", force: :cascade do |t|
    t.integer  "nmap_operating_system_id"
    t.string   "osclass_type"
    t.string   "vendor"
    t.string   "osfamily"
    t.string   "osgen"
    t.string   "accuracy"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "nmap_os_matches", force: :cascade do |t|
    t.integer  "nmap_operating_system_id"
    t.string   "name"
    t.string   "accuracy"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "line"
  end

  create_table "nmap_ports", force: :cascade do |t|
    t.integer  "nmap_host_id"
    t.string   "protocol"
    t.string   "port"
    t.string   "state"
    t.string   "reason"
    t.string   "service_name"
    t.string   "product"
    t.string   "version"
    t.string   "extra_info"
    t.string   "os_type"
    t.string   "fingerprint_method"
    t.text     "fingerprint"
    t.string   "confidence"
    t.string   "device_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "nmap_reports", force: :cascade do |t|
    t.string   "path"
    t.string   "name"
    t.string   "version"
    t.text     "arguments"
    t.string   "start_time"
    t.string   "xmloutputversion"
    t.string   "scan_type"
    t.string   "protocol"
    t.text     "services"
    t.boolean  "debugging"
    t.boolean  "verbose"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "user_id"
    t.integer  "engagement_id"
    t.boolean  "is_completed",     default: false
  end

  create_table "nmap_run_stats", force: :cascade do |t|
    t.integer  "nmap_report_id"
    t.datetime "end_time"
    t.string   "elapsed"
    t.text     "summary"
    t.string   "exit_status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "nmap_scripts", force: :cascade do |t|
    t.integer  "nmap_port_id"
    t.string   "key"
    t.text     "value"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "nmap_used_ports", force: :cascade do |t|
    t.integer  "nmap_operating_system_id"
    t.string   "state"
    t.string   "proto"
    t.string   "portid"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "notes", force: :cascade do |t|
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "title"
    t.integer  "notable_id"
    t.string   "notable_type"
  end

  create_table "ocbs", force: :cascade do |t|
    t.string   "number"
    t.integer  "engagement_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.date     "start_date"
    t.boolean  "is_active",     default: true
  end

  create_table "pocs", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "engagement_id"
    t.integer  "sub_engagement_id"
    t.string   "name"
  end

  create_table "questionnaire_responses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.text     "options",     limit: 3116480
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "user_id"
    t.integer  "customer_id"
  end

  add_index "reports", ["customer_id"], name: "index_reports_on_customer_id"

  create_table "screenshots", force: :cascade do |t|
    t.string   "file"
    t.integer  "report_id"
    t.string   "vulnerability_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "index"
    t.text     "caption"
  end

  create_table "settings", force: :cascade do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "setting_type"
    t.string   "category"
    t.string   "label"
    t.string   "tooltip"
  end

  create_table "sidekiq_errors", force: :cascade do |t|
    t.text     "exception"
    t.text     "context_hash"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "sub_engagements", force: :cascade do |t|
    t.string   "sub_engagement_name"
    t.integer  "engagement_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "system_admins", force: :cascade do |t|
    t.integer  "engagement_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "sub_engagement_id"
    t.string   "name"
  end

  create_table "user_engagements", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "engagement_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "user_problems", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "problem_id"
    t.text     "explanation"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "fname"
    t.string   "lname"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",               default: false
    t.string   "activation_digest"
    t.boolean  "activated",           default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "discount_code"
    t.string   "username"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "engagement_id"
  end

end
