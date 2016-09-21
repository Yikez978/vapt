class AddNessusTablesBack < ActiveRecord::Migration
  def change
    begin
      drop_table "nessus_attachments"
      drop_table "nessus_family_selections"
      drop_table "nessus_host_properties"
      drop_table "nessus_hosts"
      drop_table "nessus_individual_plugin_selections"
      drop_table "nessus_items"
      drop_table "nessus_patches"
      drop_table "nessus_plugins"
      drop_table "nessus_plugins_preferences"
      drop_table "nessus_policies"
      drop_table "nessus_references"
      drop_table "nessus_reports"
      drop_table "nessus_server_preferences"
      drop_table "nessus_service_descriptions"
      drop_table "nessus_versions"
    rescue
      puts "nessus tables did not exist"
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

  end
end
