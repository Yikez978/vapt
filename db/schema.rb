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

ActiveRecord::Schema.define(version: 20160926031210) do

  create_table "caches", force: :cascade do |t|
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "key",         limit: 255
    t.string   "value",       limit: 255
    t.boolean  "cache_valid", limit: 1
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "code_blocks", force: :cascade do |t|
    t.text     "code_block",                   limit: 65535
    t.string   "code_example_lang",            limit: 255
    t.text     "desc",                         limit: 65535
    t.string   "cwe_demonstrative_example_id", limit: 255
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "block_nature",                 limit: 255
  end

  create_table "custom_findings", force: :cascade do |t|
    t.string   "host",               limit: 255
    t.string   "port",               limit: 255
    t.string   "service",            limit: 255
    t.integer  "severity",           limit: 4
    t.text     "desc",               limit: 65535
    t.string   "level_of_access",    limit: 255
    t.integer  "engagement_main_id", limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "cve_database_comments", force: :cascade do |t|
    t.integer  "cve_database_id", limit: 4
    t.string   "voter",           limit: 255
    t.text     "comment",         limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "cve_database_refs", force: :cascade do |t|
    t.integer  "cve_database_id", limit: 4
    t.text     "ref",             limit: 65535
    t.string   "source",          limit: 255
    t.text     "url",             limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "cve_database_votes", force: :cascade do |t|
    t.integer  "cve_database_id", limit: 4
    t.string   "count",           limit: 255
    t.text     "vote",            limit: 65535
    t.string   "vote_type",       limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "cve_databases", force: :cascade do |t|
    t.string   "cve_database_id", limit: 255
    t.string   "status",          limit: 255
    t.string   "phase",           limit: 255
    t.string   "phase_date",      limit: 255
    t.text     "desc",            limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "cwe_alternate_terms", force: :cascade do |t|
    t.string   "term",                    limit: 255
    t.text     "desc",                    limit: 65535
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "alternate_termable_id",   limit: 4
    t.string   "alternate_termable_type", limit: 255
  end

  create_table "cwe_architechtural_paradigms", force: :cascade do |t|
    t.string   "prevalence",        limit: 255
    t.string   "name",              limit: 255
    t.integer  "paradigmable_id",   limit: 4
    t.string   "paradigmable_type", limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "cwe_audiences", force: :cascade do |t|
    t.string   "stakeholder",      limit: 255
    t.text     "stakeholder_desc", limit: 65535
    t.integer  "cwe_view_id",      limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "cwe_categories", force: :cascade do |t|
    t.integer  "cwe_cat_id",              limit: 4
    t.string   "name",                    limit: 255
    t.string   "cat_status",              limit: 255
    t.text     "desc",                    limit: 65535
    t.integer  "cwe_weakness_catalog_id", limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.text     "extended_desc",           limit: 65535
    t.string   "liklihood_of_exploits",   limit: 255
    t.string   "affected_resource",       limit: 255
  end

  create_table "cwe_common_consequences", force: :cascade do |t|
    t.string   "consequence_scope",   limit: 255
    t.string   "technical_impact",    limit: 255
    t.text     "note",                limit: 65535
    t.integer  "consequencable_id",   limit: 4
    t.string   "consequencable_type", limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "cwe_compound_elements", force: :cascade do |t|
    t.integer  "element_id",                   limit: 4
    t.string   "name",                         limit: 255
    t.string   "compound_element_abstraction", limit: 255
    t.string   "compound_element_structure",   limit: 255
    t.string   "element_status",               limit: 255
    t.text     "desc_summary",                 limit: 65535
    t.text     "ext_desc",                     limit: 65535
    t.integer  "cwe_weakness_catalog_id",      limit: 4
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "likelihood_of_exploit",        limit: 255
    t.text     "other_notes",                  limit: 65535
    t.string   "affected_resource",            limit: 255
    t.string   "casual_nature",                limit: 255
    t.string   "relevant_property",            limit: 255
  end

  create_table "cwe_content_histories", force: :cascade do |t|
    t.integer  "contentable_id",   limit: 4
    t.string   "contentable_type", limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "cwe_demonstrative_examples", force: :cascade do |t|
    t.string   "dx_id",             limit: 255
    t.text     "intro_text",        limit: 65535
    t.integer  "demo_example_id",   limit: 4
    t.string   "demo_example_type", limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "cwe_detection_methods", force: :cascade do |t|
    t.string   "method_name",          limit: 255
    t.text     "method_desc",          limit: 65535
    t.string   "method_effectiveness", limit: 255
    t.integer  "detectable_id",        limit: 4
    t.string   "detectable_type",      limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "method_id",            limit: 255
  end

  create_table "cwe_functional_areas", force: :cascade do |t|
    t.string   "functional_area",   limit: 255
    t.integer  "functionable_id",   limit: 4
    t.string   "functionable_type", limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "cwe_languages", force: :cascade do |t|
    t.string   "language_name",  limit: 255
    t.string   "language_class", limit: 255
    t.integer  "language_id",    limit: 4
    t.string   "language_type",  limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.text     "note",           limit: 65535
  end

  create_table "cwe_maintenance_notes", force: :cascade do |t|
    t.text     "note",             limit: 65535
    t.integer  "maintenable_id",   limit: 4
    t.string   "maintenable_type", limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_location",   limit: 255
    t.string   "image_title",      limit: 255
  end

  create_table "cwe_mitigations", force: :cascade do |t|
    t.string   "mitigation_id",       limit: 255
    t.string   "mitigation_phase",    limit: 255
    t.string   "mitigation_strategy", limit: 255
    t.text     "desc",                limit: 65535
    t.integer  "mitigatable_id",      limit: 4
    t.string   "mitigatable_type",    limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "cwe_mode_of_intros", force: :cascade do |t|
    t.text     "mode_of_intro",       limit: 65535
    t.integer  "mode_introable_id",   limit: 4
    t.string   "mode_introable_type", limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "cwe_modifications", force: :cascade do |t|
    t.string   "modification_source",    limit: 255
    t.string   "modifier",               limit: 255
    t.string   "modifier_org",           limit: 255
    t.date     "modification_date"
    t.text     "modification_comment",   limit: 65535
    t.integer  "cwe_content_history_id", limit: 4
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "cwe_observed_examples", force: :cascade do |t|
    t.string   "observed_example_ref", limit: 255
    t.text     "desc",                 limit: 65535
    t.integer  "observable_id",        limit: 4
    t.string   "observable_type",      limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "cwe_prev_entry_names", force: :cascade do |t|
    t.date     "name_change_date"
    t.string   "value",                  limit: 255
    t.integer  "cwe_content_history_id", limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "cwe_references", force: :cascade do |t|
    t.string   "ref_id",         limit: 255
    t.text     "ref_author",     limit: 65535
    t.string   "ref_title",      limit: 255
    t.string   "ref_section",    limit: 255
    t.string   "ref_edition",    limit: 255
    t.string   "ref_publisher",  limit: 255
    t.date     "ref_pubdate"
    t.date     "ref_date"
    t.string   "ref_link",       limit: 255
    t.integer  "referable_id",   limit: 4
    t.string   "referable_type", limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "local_ref_id",   limit: 255
  end

  create_table "cwe_related_attack_patterns", force: :cascade do |t|
    t.string   "capec_version",   limit: 255
    t.string   "capec_id",        limit: 255
    t.integer  "attackable_id",   limit: 4
    t.string   "attackable_type", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "cwe_relationship_notes", force: :cascade do |t|
    t.text     "note",                      limit: 65535
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "relationship_notable_id",   limit: 4
    t.string   "relationship_notable_type", limit: 255
  end

  create_table "cwe_relationships", force: :cascade do |t|
    t.integer  "relationship_view_id", limit: 4
    t.string   "ordinal",              limit: 255
    t.string   "target_form",          limit: 255
    t.string   "nature",               limit: 255
    t.integer  "target_id",            limit: 4
    t.integer  "relation_id",          limit: 4
    t.string   "relation_type",        limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "comment",              limit: 255
  end

  create_table "cwe_research_gaps", force: :cascade do |t|
    t.text     "research_gap",          limit: 65535
    t.integer  "research_gapable_id",   limit: 4
    t.string   "research_gapable_type", limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "cwe_submissions", force: :cascade do |t|
    t.string   "submission_source",      limit: 255
    t.string   "submitter",              limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "cwe_content_history_id", limit: 4
    t.date     "submission_date"
  end

  create_table "cwe_taxonomies", force: :cascade do |t|
    t.string   "mapped_taxonomy_name", limit: 255
    t.string   "mapped_node_id",       limit: 255
    t.string   "mapped_node_name",     limit: 255
    t.string   "mapping_fit",          limit: 255
    t.integer  "taxonomy_id",          limit: 4
    t.string   "taxonomy_type",        limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "cwe_technology_classes", force: :cascade do |t|
    t.string   "prevalence",                limit: 255
    t.string   "name",                      limit: 255
    t.integer  "technology_classable_id",   limit: 4
    t.string   "technology_classable_type", limit: 255
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "cwe_theoritical_notes", force: :cascade do |t|
    t.text     "note",                limit: 65535
    t.integer  "theory_notable_id",   limit: 4
    t.string   "theory_notable_type", limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "cwe_time_of_intros", force: :cascade do |t|
    t.text     "intro_phase",    limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "introable_id",   limit: 4
    t.string   "introable_type", limit: 255
  end

  create_table "cwe_views", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.string   "view_structure",          limit: 255
    t.string   "view_filter",             limit: 255
    t.integer  "cwe_weakness_catalog_id", limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "view_status",             limit: 255
    t.integer  "view_id",                 limit: 4
    t.text     "view_objective",          limit: 65535
  end

  create_table "cwe_weakness_catalogs", force: :cascade do |t|
    t.string   "catalog_name",    limit: 255
    t.string   "catalog_version", limit: 255
    t.date     "catalog_date"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "cwe_weakness_ordinalities", force: :cascade do |t|
    t.string   "ordinality",       limit: 255
    t.integer  "ordinalable_id",   limit: 4
    t.string   "ordinalable_type", limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "cwe_weaknesses", force: :cascade do |t|
    t.string   "weakness_id",             limit: 255
    t.string   "name",                    limit: 255
    t.string   "weakness_abstruction",    limit: 255
    t.string   "weakness_status",         limit: 255
    t.text     "desc_summary",            limit: 65535
    t.text     "ext_desc",                limit: 65535
    t.integer  "cwe_weakness_catalog_id", limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.text     "terminology_note",        limit: 65535
    t.string   "liklihood_of_exploit",    limit: 255
    t.text     "background_details",      limit: 65535
    t.string   "casual_nature",           limit: 255
    t.string   "affected_resource",       limit: 255
    t.text     "other_notes",             limit: 65535
  end

  create_table "cwe_white_box_defs", force: :cascade do |t|
    t.text     "definition_block",  limit: 65535
    t.integer  "box_defiable_id",   limit: 4
    t.string   "box_defiable_type", limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "engagement_creds", force: :cascade do |t|
    t.string   "ip",            limit: 255
    t.text     "pwdump",        limit: 65535
    t.string   "password",      limit: 255
    t.text     "description",   limit: 65535
    t.integer  "user_id",       limit: 4
    t.integer  "engagement_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "engagement_files", force: :cascade do |t|
    t.integer  "user_id",            limit: 4
    t.integer  "engagement_id",      limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "asset_file_name",    limit: 255
    t.string   "asset_content_type", limit: 255
    t.integer  "asset_file_size",    limit: 4
    t.datetime "asset_updated_at"
  end

  create_table "engagement_main_users", force: :cascade do |t|
    t.integer "user_id",            limit: 4
    t.integer "engagement_main_id", limit: 4
  end

  create_table "engagement_mains", force: :cascade do |t|
    t.string   "host",          limit: 255
    t.text     "ports",         limit: 65535
    t.string   "services",      limit: 255
    t.string   "vulns",         limit: 255
    t.string   "host_name",     limit: 255
    t.string   "os",            limit: 255
    t.integer  "user_id",       limit: 4
    t.integer  "engagement_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "aasm_state",    limit: 255
    t.string   "mac",           limit: 255
  end

  create_table "engagement_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "engagements", force: :cascade do |t|
    t.string   "engagement_name",    limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.text     "note",               limit: 65535
    t.date     "note_add_date"
    t.integer  "engagement_type_id", limit: 4
    t.date     "start_date"
    t.date     "end_date"
    t.string   "aasm_state",         limit: 255
    t.integer  "user_id",            limit: 4
    t.string   "ancestry",           limit: 255
    t.integer  "customer_id",        limit: 4
  end

  add_index "engagements", ["ancestry"], name: "index_engagements_on_ancestry", using: :btree
  add_index "engagements", ["customer_id"], name: "index_engagements_on_customer_id", using: :btree

  create_table "evidences", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "rights",             limit: 255
    t.string   "size",               limit: 255
    t.string   "date",               limit: 255
    t.string   "dir_type",           limit: 255
    t.string   "ancestry",           limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "asset_file_name",    limit: 255
    t.string   "asset_content_type", limit: 255
    t.integer  "asset_file_size",    limit: 4
    t.datetime "asset_updated_at"
    t.integer  "engagement_id",      limit: 4
    t.integer  "engagement_main_id", limit: 4
    t.string   "full_path",          limit: 255
  end

  create_table "exploit_platforms", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "exploit_types", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "exploits", force: :cascade do |t|
    t.integer  "exploit_platform_id",      limit: 4
    t.integer  "exploit_type_id",          limit: 4
    t.integer  "exploit_db_id",            limit: 4
    t.string   "file",                     limit: 255
    t.text     "description",              limit: 65535
    t.string   "date",                     limit: 255
    t.string   "author",                   limit: 255
    t.string   "port",                     limit: 255
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "source",                   limit: 255
    t.integer  "user_id",                  limit: 4
    t.boolean  "is_verified",              limit: 1,     default: false
    t.string   "custom_file_file_name",    limit: 255
    t.string   "custom_file_content_type", limit: 255
    t.integer  "custom_file_file_size",    limit: 4
    t.datetime "custom_file_updated_at"
  end

  create_table "host_creds", force: :cascade do |t|
    t.string   "ip",                 limit: 255
    t.text     "pwdump",             limit: 65535
    t.string   "password",           limit: 255
    t.text     "description",        limit: 65535
    t.integer  "engagement_main_id", limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "host_infos", force: :cascade do |t|
    t.string   "ip",                 limit: 255
    t.string   "mac",                limit: 255
    t.string   "host_name",          limit: 255
    t.string   "os",                 limit: 255
    t.string   "service_port",       limit: 255
    t.string   "service_protocol",   limit: 255
    t.string   "service_name",       limit: 255
    t.string   "service_banner",     limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "engagement_main_id", limit: 4
    t.string   "service_status",     limit: 255
  end

  create_table "host_vulns", force: :cascade do |t|
    t.integer  "port",               limit: 4
    t.integer  "severity",           limit: 4
    t.string   "aasm_state",         limit: 255
    t.string   "cve",                limit: 255
    t.string   "cwe",                limit: 255
    t.string   "level_of_access",    limit: 255
    t.integer  "engagement_main_id", limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.text     "synopsis",           limit: 65535
    t.string   "vuln_name",          limit: 255
  end

  create_table "hosts", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "mac",           limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "engagement_id", limit: 4
  end

  create_table "ips", force: :cascade do |t|
    t.string   "ip",                limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "engagement_id",     limit: 4
    t.integer  "sub_engagement_id", limit: 4
  end

  create_table "metasploit_credential_cores", force: :cascade do |t|
    t.integer  "core_id",               limit: 4
    t.integer  "origin_id",             limit: 4
    t.string   "origin_type",           limit: 255
    t.integer  "private_id",            limit: 4
    t.integer  "public_id",             limit: 4
    t.string   "realm_id",              limit: 255
    t.integer  "workspace_id",          limit: 4
    t.datetime "metasploit_created_at"
    t.datetime "metasploit_updated_at"
    t.integer  "logins_count",          limit: 4
    t.integer  "metasploit_report_id",  limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "metasploit_credential_logins", force: :cascade do |t|
    t.integer  "login_id",              limit: 4
    t.integer  "core_id",               limit: 4
    t.integer  "service_id",            limit: 4
    t.string   "access_level",          limit: 255
    t.string   "status",                limit: 255
    t.datetime "last_attempted_at"
    t.datetime "metasploit_created_at"
    t.datetime "metasploit_updated_at"
    t.integer  "metasploit_report_id",  limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "metasploit_credential_origins", force: :cascade do |t|
    t.integer  "origin_id",             limit: 4
    t.integer  "service_id",            limit: 4
    t.string   "module_full_name",      limit: 255
    t.datetime "metasploit_created_at"
    t.datetime "metasploit_updated_at"
    t.integer  "metasploit_report_id",  limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "metasploit_credential_privates", force: :cascade do |t|
    t.integer  "private_id",            limit: 4
    t.string   "private_type",          limit: 255
    t.text     "data",                  limit: 65535
    t.datetime "metasploit_created_at"
    t.datetime "metasploit_updated_at"
    t.integer  "metasploit_report_id",  limit: 4
    t.string   "jtr_format",            limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "metasploit_credential_publics", force: :cascade do |t|
    t.integer  "public_id",             limit: 4
    t.string   "username",              limit: 255
    t.datetime "metasploit_created_at"
    t.datetime "metasploit_updated_at"
    t.integer  "metasploit_report_id",  limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "metasploit_events", force: :cascade do |t|
    t.integer  "event_id",              limit: 4
    t.integer  "workspace_id",          limit: 4
    t.integer  "host_id",               limit: 4
    t.datetime "metasploit_created_at"
    t.string   "name",                  limit: 255
    t.datetime "metasploit_updated_at"
    t.string   "critical",              limit: 255
    t.string   "seen",                  limit: 255
    t.string   "username",              limit: 255
    t.text     "info",                  limit: 65535
    t.string   "module_rhost",          limit: 255
    t.string   "module_name",           limit: 255
    t.integer  "metasploit_report_id",  limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "metasploit_exploit_attempts", force: :cascade do |t|
    t.integer  "exploit_attempt_id", limit: 4
    t.integer  "service_id",         limit: 4
    t.integer  "vuln_id",            limit: 4
    t.datetime "attempted_at"
    t.string   "exploited",          limit: 255
    t.string   "fail_reason",        limit: 255
    t.string   "username",           limit: 255
    t.string   "module",             limit: 255
    t.string   "session_id",         limit: 255
    t.string   "loot_id",            limit: 255
    t.integer  "port",               limit: 4
    t.string   "proto",              limit: 255
    t.string   "fail_detail",        limit: 255
    t.integer  "metasploit_host_id", limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "metasploit_host_notes", force: :cascade do |t|
    t.integer  "note_id",               limit: 4
    t.datetime "metasploit_created_at"
    t.datetime "metasploit_updated_at"
    t.string   "ntype",                 limit: 255
    t.integer  "workspace_id",          limit: 4
    t.integer  "service_id",            limit: 4
    t.string   "critical",              limit: 255
    t.string   "seen",                  limit: 255
    t.string   "vuln_id",               limit: 255
    t.text     "data",                  limit: 65535
    t.integer  "metasploit_host_id",    limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "metasploit_host_services", force: :cascade do |t|
    t.integer  "service_id",            limit: 4
    t.integer  "metasploit_host_id",    limit: 4
    t.datetime "metasploit_created_at"
    t.datetime "metasploit_updated_at"
    t.integer  "port",                  limit: 4
    t.string   "proto",                 limit: 255
    t.string   "state",                 limit: 255
    t.string   "name",                  limit: 255
    t.text     "info",                  limit: 65535
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "metasploit_host_vulns", force: :cascade do |t|
    t.integer  "vuln_id",                  limit: 4
    t.integer  "service_id",               limit: 4
    t.datetime "metasploit_created_at"
    t.datetime "metasploit_updated_at"
    t.string   "name",                     limit: 255
    t.text     "info",                     limit: 65535
    t.string   "exploited_at",             limit: 255
    t.integer  "vuln_detail_count",        limit: 4
    t.integer  "vuln_attempt_count",       limit: 4
    t.string   "nexpose_data_vuln_def_id", limit: 255
    t.string   "origin_id",                limit: 255
    t.string   "origin_type",              limit: 255
    t.text     "notes",                    limit: 65535
    t.text     "vuln_details",             limit: 65535
    t.text     "vuln_attempts",            limit: 65535
    t.integer  "metasploit_host_id",       limit: 4
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "metasploit__ref_id",       limit: 4
  end

  create_table "metasploit_hosts", force: :cascade do |t|
    t.string   "metasploit_created_at", limit: 255
    t.string   "address",               limit: 255
    t.string   "mac",                   limit: 255
    t.string   "comm",                  limit: 255
    t.string   "name",                  limit: 255
    t.string   "state",                 limit: 255
    t.string   "os_name",               limit: 255
    t.string   "os_flavor",             limit: 255
    t.string   "os_sp",                 limit: 255
    t.string   "os_lang",               limit: 255
    t.string   "arch",                  limit: 255
    t.string   "workspace_id",          limit: 255
    t.datetime "metasploit_updated_at",               null: false
    t.string   "purpose",               limit: 255
    t.string   "info",                  limit: 255
    t.string   "metasploit_scope",      limit: 255
    t.string   "note_count",            limit: 255
    t.string   "vuln_count",            limit: 255
    t.string   "service_count",         limit: 255
    t.string   "host_detail_count",     limit: 255
    t.string   "exploit_attempt_count", limit: 255
    t.string   "cred_count",            limit: 255
    t.string   "history_count",         limit: 255
    t.string   "detected_arch",         limit: 255
    t.integer  "metasploit_report_id",  limit: 4
    t.datetime "created_at",                          null: false
    t.text     "comments",              limit: 65535
    t.string   "virtual_host",          limit: 255
    t.integer  "metasploit_id",         limit: 4
  end

  create_table "metasploit_module_arches", force: :cascade do |t|
    t.integer  "module_archs_id",             limit: 4
    t.string   "name",                        limit: 255
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "metasploit_module_detail_id", limit: 4
  end

  create_table "metasploit_module_authors", force: :cascade do |t|
    t.integer  "author_id",                   limit: 4
    t.integer  "metasploit_module_detail_id", limit: 4
    t.string   "name",                        limit: 255
    t.string   "email",                       limit: 255
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "metasploit_module_details", force: :cascade do |t|
    t.integer  "module_id",            limit: 4
    t.datetime "mtime"
    t.string   "file",                 limit: 255
    t.string   "mtype",                limit: 255
    t.string   "refname",              limit: 255
    t.string   "fullname",             limit: 255
    t.string   "name",                 limit: 255
    t.integer  "rank",                 limit: 4
    t.text     "description",          limit: 65535
    t.string   "license",              limit: 255
    t.string   "privileged",           limit: 255
    t.datetime "disclosure_date"
    t.string   "default_target",       limit: 255
    t.string   "default_action",       limit: 255
    t.string   "stance",               limit: 255
    t.string   "ready",                limit: 255
    t.integer  "metasploit_report_id", limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "metasploit_module_platforms", force: :cascade do |t|
    t.integer  "module_platform_id",          limit: 4
    t.string   "name",                        limit: 255
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "metasploit_module_detail_id", limit: 4
  end

  create_table "metasploit_module_refs", force: :cascade do |t|
    t.integer  "module_ref_id",               limit: 4
    t.string   "name",                        limit: 255
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "metasploit_module_detail_id", limit: 4
  end

  create_table "metasploit_module_targets", force: :cascade do |t|
    t.integer  "module_target_id",            limit: 4
    t.string   "name",                        limit: 255
    t.integer  "metasploit_index",            limit: 4
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "metasploit_module_detail_id", limit: 4
  end

  create_table "metasploit_refs", force: :cascade do |t|
    t.string   "ref",                     limit: 255
    t.integer  "metasploit_host_vuln_id", limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "metasploit_reports", force: :cascade do |t|
    t.string   "path",            limit: 255
    t.string   "time",            limit: 255
    t.string   "metasploit_user", limit: 255
    t.string   "project",         limit: 255
    t.string   "product",         limit: 255
    t.integer  "user_id",         limit: 4
    t.integer  "engagement_id",   limit: 4
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.boolean  "is_completed",    limit: 1,   default: false
  end

  create_table "metasploit_services", force: :cascade do |t|
    t.integer  "service_id",            limit: 4
    t.integer  "host_id",               limit: 4
    t.datetime "metasploit_created_at"
    t.datetime "metasploit_updated_at"
    t.integer  "port",                  limit: 4
    t.string   "proto",                 limit: 255
    t.string   "state",                 limit: 255
    t.string   "name",                  limit: 255
    t.text     "info",                  limit: 65535
    t.integer  "metasploit_report_id",  limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "nessus_attachments", force: :cascade do |t|
    t.integer "item_id",       limit: 4
    t.string  "name",          limit: 255
    t.string  "ttype",         limit: 255
    t.string  "ahash",         limit: 255
    t.text    "value",         limit: 65535
    t.integer "user_id",       limit: 4
    t.integer "engagement_id", limit: 4
  end

  create_table "nessus_family_selections", force: :cascade do |t|
    t.integer "policy_id",     limit: 4
    t.string  "family_name",   limit: 255
    t.string  "status",        limit: 255
    t.integer "user_id",       limit: 4
    t.integer "engagement_id", limit: 4
  end

  create_table "nessus_host_properties", force: :cascade do |t|
    t.integer "host_id",       limit: 4
    t.string  "name",          limit: 255
    t.text    "value",         limit: 4294967295
    t.integer "user_id",       limit: 4
    t.integer "engagement_id", limit: 4
  end

  create_table "nessus_hosts", force: :cascade do |t|
    t.integer  "nessus_report_id", limit: 4
    t.string   "name",             limit: 255
    t.string   "os",               limit: 255
    t.text     "mac",              limit: 4294967295
    t.datetime "start"
    t.datetime "end"
    t.string   "ip",               limit: 255
    t.string   "fqdn",             limit: 255
    t.string   "netbios",          limit: 255
    t.text     "notes",            limit: 65535
    t.integer  "risk_score",       limit: 4
    t.integer  "user_id",          limit: 4
    t.integer  "engagement_id",    limit: 4
  end

  create_table "nessus_individual_plugin_selections", force: :cascade do |t|
    t.string  "policy_id",     limit: 255
    t.integer "plugin_id",     limit: 4
    t.string  "plugin_name",   limit: 255
    t.string  "family",        limit: 255
    t.string  "status",        limit: 255
    t.integer "user_id",       limit: 4
    t.integer "engagement_id", limit: 4
  end

  create_table "nessus_items", force: :cascade do |t|
    t.integer "host_id",                    limit: 4
    t.integer "plugin_id",                  limit: 4
    t.integer "attachment_id",              limit: 4
    t.text    "plugin_output",              limit: 4294967295
    t.integer "port",                       limit: 4
    t.string  "svc_name",                   limit: 255
    t.string  "protocol",                   limit: 255
    t.integer "severity",                   limit: 4
    t.string  "plugin_name",                limit: 255
    t.boolean "verified",                   limit: 1
    t.text    "cm_compliance_info",         limit: 4294967295
    t.text    "cm_compliance_actual_value", limit: 4294967295
    t.text    "cm_compliance_check_id",     limit: 4294967295
    t.text    "cm_compliance_policy_value", limit: 4294967295
    t.text    "cm_compliance_audit_file",   limit: 4294967295
    t.text    "cm_compliance_check_name",   limit: 4294967295
    t.text    "cm_compliance_result",       limit: 4294967295
    t.text    "cm_compliance_output",       limit: 4294967295
    t.text    "cm_compliance_reference",    limit: 4294967295
    t.text    "cm_compliance_see_also",     limit: 4294967295
    t.text    "cm_compliance_solution",     limit: 4294967295
    t.integer "real_severity",              limit: 4
    t.integer "risk_score",                 limit: 4
    t.integer "user_id",                    limit: 4
    t.integer "engagement_id",              limit: 4
  end

  add_index "nessus_items", ["host_id"], name: "index_nessus_items_on_host_id", using: :btree
  add_index "nessus_items", ["plugin_id"], name: "index_nessus_items_on_plugin_id", using: :btree

  create_table "nessus_patches", force: :cascade do |t|
    t.integer "host_id",       limit: 4
    t.string  "name",          limit: 255
    t.string  "value",         limit: 255
    t.integer "user_id",       limit: 4
    t.integer "engagement_id", limit: 4
  end

  create_table "nessus_plugins", force: :cascade do |t|
    t.integer  "plugin_id",                    limit: 4
    t.string   "plugin_name",                  limit: 255
    t.string   "family_name",                  limit: 255
    t.text     "description",                  limit: 4294967295
    t.string   "plugin_version",               limit: 255
    t.datetime "plugin_publication_date"
    t.datetime "plugin_modification_date"
    t.datetime "vuln_publication_date"
    t.string   "cvss_vector",                  limit: 255
    t.float    "cvss_base_score",              limit: 24
    t.string   "cvss_temporal_score",          limit: 255
    t.string   "cvss_temporal_vector",         limit: 255
    t.string   "exploitability_ease",          limit: 255
    t.string   "exploit_framework_core",       limit: 255
    t.string   "exploit_framework_metasploit", limit: 255
    t.string   "metasploit_name",              limit: 255
    t.string   "exploit_framework_canvas",     limit: 255
    t.string   "canvas_package",               limit: 255
    t.string   "exploit_available",            limit: 255
    t.string   "risk_factor",                  limit: 255
    t.text     "solution",                     limit: 4294967295
    t.text     "synopsis",                     limit: 4294967295
    t.string   "plugin_type",                  limit: 255
    t.string   "exploit_framework_exploithub", limit: 255
    t.string   "exploithub_sku",               limit: 255
    t.string   "stig_severity",                limit: 255
    t.string   "fname",                        limit: 255
    t.string   "always_run",                   limit: 255
    t.string   "script_version",               limit: 255
    t.string   "d2_elliot_name",               limit: 255
    t.string   "exploit_framework_d2_elliot",  limit: 255
    t.string   "exploited_by_malware",         limit: 255
    t.boolean  "rollup",                       limit: 1
    t.integer  "risk_score",                   limit: 4
    t.string   "compliance",                   limit: 255
    t.string   "root_cause",                   limit: 255
    t.string   "agent",                        limit: 255
    t.boolean  "potential_vulnerability",      limit: 1
    t.boolean  "in_the_news",                  limit: 1
    t.boolean  "exploited_by_nessus",          limit: 1
    t.boolean  "unsupported_by_vendor",        limit: 1
    t.boolean  "default_account",              limit: 1
    t.integer  "user_id",                      limit: 4
    t.integer  "engagement_id",                limit: 4
    t.integer  "policy_id",                    limit: 4
  end

  create_table "nessus_plugins_preferences", force: :cascade do |t|
    t.integer "policy_id",         limit: 4
    t.integer "plugin_id",         limit: 4
    t.string  "plugin_name",       limit: 255
    t.string  "fullname",          limit: 255
    t.string  "preference_name",   limit: 255
    t.string  "preference_type",   limit: 255
    t.string  "preference_values", limit: 255
    t.string  "selected_values",   limit: 255
    t.integer "user_id",           limit: 4
    t.integer "engagement_id",     limit: 4
  end

  create_table "nessus_policies", force: :cascade do |t|
    t.string  "name",          limit: 255
    t.text    "comments",      limit: 65535
    t.string  "owner",         limit: 255
    t.string  "visibility",    limit: 255
    t.integer "user_id",       limit: 4
    t.integer "engagement_id", limit: 4
  end

  create_table "nessus_references", force: :cascade do |t|
    t.integer "plugin_id",      limit: 4
    t.string  "reference_name", limit: 255
    t.text    "value",          limit: 65535
    t.integer "user_id",        limit: 4
    t.integer "engagement_id",  limit: 4
  end

  add_index "nessus_references", ["plugin_id"], name: "index_nessus_references_on_plugin_id", using: :btree

  create_table "nessus_reports", force: :cascade do |t|
    t.integer "policy_id",     limit: 4
    t.string  "name",          limit: 255
    t.integer "user_id",       limit: 4
    t.integer "engagement_id", limit: 4
  end

  create_table "nessus_server_preferences", force: :cascade do |t|
    t.integer "policy_id",     limit: 4
    t.string  "name",          limit: 255
    t.text    "value",         limit: 4294967295
    t.integer "user_id",       limit: 4
    t.integer "engagement_id", limit: 4
  end

  create_table "nessus_service_descriptions", force: :cascade do |t|
    t.string  "name",          limit: 255
    t.integer "port",          limit: 4
    t.string  "description",   limit: 255
    t.integer "user_id",       limit: 4
    t.integer "engagement_id", limit: 4
  end

  create_table "nessus_versions", force: :cascade do |t|
    t.string  "version",       limit: 255
    t.integer "user_id",       limit: 4
    t.integer "engagement_id", limit: 4
  end

  create_table "nmap_cpes", force: :cascade do |t|
    t.integer  "nmap_port_id", limit: 4
    t.string   "part",         limit: 255
    t.string   "vendor",       limit: 255
    t.string   "product",      limit: 255
    t.string   "version",      limit: 255
    t.string   "cpe_update",   limit: 255
    t.string   "edition",      limit: 255
    t.string   "language",     limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "nmap_host_ipidsequences", force: :cascade do |t|
    t.integer  "nmap_host_id", limit: 4
    t.text     "values",       limit: 65535
    t.text     "description",  limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "nmap_host_tcpsequences", force: :cascade do |t|
    t.integer  "nmap_host_id", limit: 4
    t.string   "index",        limit: 255
    t.text     "difficulty",   limit: 65535
    t.text     "values",       limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "nmap_host_tcptssequences", force: :cascade do |t|
    t.integer  "nmap_host_id", limit: 4
    t.text     "values",       limit: 65535
    t.text     "description",  limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "nmap_host_traceroutes", force: :cascade do |t|
    t.integer  "nmap_host_id", limit: 4
    t.string   "port",         limit: 255
    t.string   "protocol",     limit: 255
    t.string   "ttl",          limit: 255
    t.string   "ipaddr",       limit: 255
    t.string   "rtt",          limit: 255
    t.text     "host",         limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "nmap_host_uptimes", force: :cascade do |t|
    t.integer  "nmap_host_id", limit: 4
    t.string   "seconds",      limit: 255
    t.string   "last_boot",    limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "nmap_hostnames", force: :cascade do |t|
    t.integer  "nmap_host_id", limit: 4
    t.string   "host_type",    limit: 255
    t.string   "name",         limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "nmap_hosts", force: :cascade do |t|
    t.integer  "nmap_report_id", limit: 4
    t.string   "ip",             limit: 255
    t.string   "ipv4",           limit: 255
    t.string   "ipv6",           limit: 255
    t.string   "address",        limit: 255
    t.string   "mac",            limit: 255
    t.string   "vendor",         limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "nmap_operating_systems", force: :cascade do |t|
    t.integer  "nmap_host_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "nmap_os_classes", force: :cascade do |t|
    t.integer  "nmap_operating_system_id", limit: 4
    t.string   "osclass_type",             limit: 255
    t.string   "vendor",                   limit: 255
    t.string   "osfamily",                 limit: 255
    t.string   "osgen",                    limit: 255
    t.string   "accuracy",                 limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "nmap_os_matches", force: :cascade do |t|
    t.integer  "nmap_operating_system_id", limit: 4
    t.string   "name",                     limit: 255
    t.string   "accuracy",                 limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "line",                     limit: 255
  end

  create_table "nmap_ports", force: :cascade do |t|
    t.integer  "nmap_host_id",       limit: 4
    t.string   "protocol",           limit: 255
    t.string   "port",               limit: 255
    t.string   "state",              limit: 255
    t.string   "reason",             limit: 255
    t.string   "service_name",       limit: 255
    t.string   "product",            limit: 255
    t.string   "version",            limit: 255
    t.string   "extra_info",         limit: 255
    t.string   "os_type",            limit: 255
    t.string   "fingerprint_method", limit: 255
    t.text     "fingerprint",        limit: 65535
    t.string   "confidence",         limit: 255
    t.string   "device_type",        limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "nmap_reports", force: :cascade do |t|
    t.string   "path",             limit: 255
    t.string   "name",             limit: 255
    t.string   "version",          limit: 255
    t.text     "arguments",        limit: 65535
    t.string   "start_time",       limit: 255
    t.string   "xmloutputversion", limit: 255
    t.string   "scan_type",        limit: 255
    t.string   "protocol",         limit: 255
    t.text     "services",         limit: 65535
    t.boolean  "debugging",        limit: 1
    t.boolean  "verbose",          limit: 1
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "user_id",          limit: 4
    t.integer  "engagement_id",    limit: 4
    t.boolean  "is_completed",     limit: 1,     default: false
  end

  create_table "nmap_run_stats", force: :cascade do |t|
    t.integer  "nmap_report_id", limit: 4
    t.datetime "end_time"
    t.string   "elapsed",        limit: 255
    t.text     "summary",        limit: 65535
    t.string   "exit_status",    limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "nmap_scripts", force: :cascade do |t|
    t.integer  "nmap_port_id", limit: 4
    t.string   "key",          limit: 255
    t.text     "value",        limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "nmap_used_ports", force: :cascade do |t|
    t.integer  "nmap_operating_system_id", limit: 4
    t.string   "state",                    limit: 255
    t.string   "proto",                    limit: 255
    t.string   "portid",                   limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "notes", force: :cascade do |t|
    t.text     "description",  limit: 65535
    t.integer  "user_id",      limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "title",        limit: 255
    t.integer  "notable_id",   limit: 4
    t.string   "notable_type", limit: 255
  end

  create_table "ocbs", force: :cascade do |t|
    t.string   "number",        limit: 255
    t.integer  "engagement_id", limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.date     "start_date"
    t.boolean  "is_active",     limit: 1,   default: true
  end

  create_table "pocs", force: :cascade do |t|
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "engagement_id",     limit: 4
    t.integer  "sub_engagement_id", limit: 4
    t.string   "name",              limit: 255
  end

  create_table "reports", force: :cascade do |t|
    t.text     "options",     limit: 16777215
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "user_id",     limit: 4
    t.integer  "customer_id", limit: 4
  end

  add_index "reports", ["customer_id"], name: "index_reports_on_customer_id", using: :btree

  create_table "screenshots", force: :cascade do |t|
    t.string   "file",             limit: 255
    t.integer  "report_id",        limit: 4
    t.string   "vulnerability_id", limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "index",            limit: 4
    t.text     "caption",          limit: 65535
  end

  create_table "settings", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "value",        limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "setting_type", limit: 255
    t.string   "category",     limit: 255
    t.string   "label",        limit: 255
    t.string   "tooltip",      limit: 255
  end

  create_table "sidekiq_errors", force: :cascade do |t|
    t.text     "exception",    limit: 65535
    t.text     "context_hash", limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "sub_engagements", force: :cascade do |t|
    t.string   "sub_engagement_name", limit: 255
    t.integer  "engagement_id",       limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "system_admins", force: :cascade do |t|
    t.integer  "engagement_id",     limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "sub_engagement_id", limit: 4
    t.string   "name",              limit: 255
  end

  create_table "user_engagements", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "engagement_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "fname",               limit: 255
    t.string   "lname",               limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "password_digest",     limit: 255
    t.string   "remember_digest",     limit: 255
    t.boolean  "admin",               limit: 1,   default: false
    t.string   "reset_digest",        limit: 255
    t.datetime "reset_sent_at"
    t.string   "discount_code",       limit: 255
    t.string   "username",            limit: 255
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
    t.integer  "engagement_id",       limit: 4
  end

  add_foreign_key "engagements", "customers"
  add_foreign_key "reports", "customers"
end
