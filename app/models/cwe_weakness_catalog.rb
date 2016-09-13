class CweWeaknessCatalog < ActiveRecord::Base
	has_many :cwe_views
	has_many :cwe_categories
	has_many :cwe_weaknesses
	has_many :cwe_compound_elements

	def self.populate_data_from_cwe_xml(file_path)
		@doc = Nokogiri::XML(File.open(file_path))

		CweWeaknessCatalog.delete_all
		CweView.delete_all
		CweAudience.delete_all
		CweContentHistory.delete_all
		CweModification.delete_all
		CwePrevEntryName.delete_all
		CweSubmission.delete_all
		CweRelationship.delete_all
		CweMaintenanceNote.delete_all
		CweReference.delete_all
		CweCategory.delete_all
		CweTaxonomy.delete_all
		CweTimeOfIntro.delete_all
		CweLanguage.delete_all
		CweMitigation.delete_all
		CweRelatedAttackPattern.delete_all
		CweDemonstrativeExample.delete_all
		CweCommonConsequence.delete_all
		CweWhiteBoxDef.delete_all
		CweWeakness.delete_all
		CweRelationshipNote.delete_all
		CweAlternateTerm.delete_all
		CweWeaknessOrdinality.delete_all
		CweObservedExample.delete_all
		CweDetectionMethod.delete_all
		CweCompoundElement.delete_all
		CweTechnologyClass.delete_all
		CweTheoriticalNote.delete_all
		CweResearchGap.delete_all
		CweFunctionalArea.delete_all
		CweModeOfIntro.delete_all
		CweArchitechturalParadigm.delete_all
		CodeBlock.delete_all

		@doc.xpath('//Weakness_Catalog').each do |node|
			
			#Populate cwe_weakness_catalog table

			cwe_weakness_catalog = CweWeaknessCatalog.new
			cwe_weakness_catalog.catalog_name = node[:Catalog_Name]
			cwe_weakness_catalog.catalog_version = node[:Catalog_Version]
			cwe_weakness_catalog.catalog_date = node[:Catalog_Date]
			cwe_weakness_catalog.save

			#Populate cwe_view table

			node.search("View").each do |view|
				name = view[:Name] rescue nil
				view_status = view[:Status] rescue nil
				view_id = view[:ID] rescue nil
				view_structure = ""
				view_objective = ""
				view_filter = ""
				view.search("View_Structure").each do |cwe_view_structure|
					view_structure = cwe_view_structure.content rescue nil
				end
				view.search("View_Objective").each do |cwe_view_objective|
					view_objective = cwe_view_objective.search("Text").map(&:text).join('')
				end
				view.search("View_Filter").each do |cwe_view_filter|
					view_filter = cwe_view_filter.content rescue nil
				end
				cwe_view = cwe_weakness_catalog.cwe_views.create(name: name, view_status: view_status, view_id: view_id, view_structure: view_structure, view_objective: view_objective, view_filter: view_filter)

				view.search("Audience").each do |cwe_audience|
					stakeholder = cwe_audience.search("Stackholder").map(&:text).join('')
					stakeholder_description = ""
					cwe_audience.search("Stakeholder_Description").each do |cwe_stakeholder_description|
						stakeholder_description = cwe_stakeholder_description.search("Text").map(&:text).join('')
					end
					cwe_view.cwe_audiences.create(stakeholder: stakeholder, stakeholder_desc: stakeholder_description)

					cwe_content_history_view = cwe_view.cwe_content_histories.create

					view.search("Modification").each do |cwe_modification|
						modification_source = cwe_modification[:Modification_Source]
						modifier = ""
						modifier_org = ""
						modification_date = ""
						modification_comment = ""
						cwe_modification.search("Modifier").each do |cwe_modifier|
							modifier = cwe_modifier.content rescue nil
						end
						cwe_modification.search("Modifier_Organization").each do |cwe_modifier_organization|
							modifier_org = cwe_modifier_organization.content rescue nil
						end
						cwe_modification.search("Modification_Date").each do |cwe_modification_date|
							modification_date = cwe_modification_date.content rescue nil
						end
						cwe_modification.search("Modification_Comment").each do |cwe_modification_comment|
							modification_comment = cwe_modification_comment.content rescue nil
						end
						cwe_content_history_view.cwe_modifications.create(modification_source: modification_source, modifier: modifier, modifier_org: modifier_org, modification_date: modification_date, modification_comment: modification_comment)
					end

					view.search("Previous_Entry_Name").each do |previous_entry_name|
						name_change_date = previous_entry_name[:Name_Change_Date] rescue nil
						value = previous_entry_name.content rescue nil
						cwe_content_history_view.cwe_prev_entry_names.create(name_change_date: name_change_date, value: value)
					end

					view.search("Submission").each do |submission|
						submission_source = submission[:Submission_Source] rescue nil
						submitter = ""
						submission_date = ""
						submission.search("Submitter").each do |cwe_submitter|
							submitter = cwe_submitter.content rescue nil
						end
						submission.search("Submission_Date").each do |cwe_submission_date|
							submission_date = cwe_submission_date.content rescue nil
						end
						cwe_content_history_view.cwe_submissions.create(submission_source: submission_source, submitter: submitter, submission_date: submission_date)
					end

					view.search("Relationship").each do |cwe_relationship|
						relationship_view_id = ""
						ordinal = ""
						target_form = ""
						nature = ""
						target_id = ""
						cwe_relationship.search("Relationship_View_ID").each do |relationship_view|	
							relationship_view_id = relationship_view.content rescue nil
							ordinal = relationship_view[:Ordinal] rescue nil
						end
						cwe_relationship.search("Relationship_Target_Form").each do |relationship_target_form|
							target_form = relationship_target_form.content rescue nil
						end
						cwe_relationship.search("Relationship_Nature").each do |relationship_nature|
							nature = relationship_nature.content rescue nil
						end
						cwe_relationship.search("Relationship_Target_ID").each do |relationship_target_id|
							target_id = relationship_target_id.content rescue nil
						end
						comment = cwe_relationship.search("comment()")
						cwe_view.cwe_relationships.create(relationship_view_id: relationship_view_id, ordinal: ordinal, target_form: target_form, nature: nature, target_id: target_id, comment: comment)
					end

					view.search("Maintenance_Note").each do |cwe_note|
						note = cwe_note.search("Text").map(&:text).join('')
						image_location = ""
						image_title = ""
						cwe_note.search("Image_Location").each do |cwe_image_location|
							image_location = cwe_image_location.content rescue nil
						end
						cwe_note.search("Image_Title").each do |cwe_image_title|
							image_title = cwe_image_title.content rescue nil
						end
						cwe_view.cwe_maintenance_note.create(note: note, image_location: image_location, image_title: image_title)
					end

					view.search("Reference").each do |cwe_reference|
						ref_id = cwe_reference[:Reference_ID] rescue nil
						local_ref_id = cwe_reference[:Local_Reference_ID] rescue nil
						ref_author = cwe_reference.search("Reference_Author").map(&:text).join(',')
						ref_title = ""
						ref_section = ""
						ref_edition = ""
						ref_publisher = ""
						ref_pubdate = ""
						ref_date = ""
						ref_link = ""
						cwe_reference.search("Reference_Title").each do |cwe_ref_title|
							ref_title = cwe_ref_title.content rescue nil
						end
						cwe_reference.search("Reference_Section").each do |cwe_ref_section|
							ref_section = cwe_ref_section.content rescue nil
						end
						cwe_reference.search("Reference_Edition").each do |cwe_ref_edition|
							ref_edition = cwe_ref_edition.content rescue nil
						end
						cwe_reference.search("Reference_Publisher").each do |cwe_ref_pub|
							ref_publisher = cwe_ref_pub.content rescue nil
						end
						cwe_reference.search("Reference_PubDate").each do |cwe_ref_pubdate|
							ref_pubdate = cwe_ref_pubdate.content rescue nil
						end
						cwe_reference.search("Reference_Date").each do |cwe_ref_date|
							ref_date = cwe_ref_date.content rescue nil
						end
						cwe_reference.search("Reference_Link").each do |cwe_ref_link|
							ref_link = cwe_ref_link.content rescue nil
						end
						cwe_view.cwe_references.create(ref_id: ref_id, ref_author: ref_author, ref_title: ref_title, ref_section: ref_section, ref_edition: ref_edition, ref_publisher: ref_publisher, ref_pubdate: ref_pubdate, ref_date: ref_date, ref_link: ref_link, local_ref_id: local_ref_id)
					end
				end
			end

			node.search("Category").each do |category|
				cwe_cat_id = category[:ID] rescue nil
				name = category[:Name] rescue nil
				cat_status = category[:Status] rescue nil
				desc = ""
				likelihood_of_exploit = ""
				extended_desc = ""
				affected_resource = ""
				category.search("Description_Summary").each do |cwe_cat_desc|
					desc = cwe_cat_desc.content rescue nil
				end
				category.search("Likelihood_of_Exploit").each do |cwe_likelihood_of_exploit|
					likelihood_of_exploit = cwe_likelihood_of_exploit.content rescue nil
				end
				category.search("Extended_Description").each do |cwe_ext_desc|
					extended_desc = cwe_ext_desc.search("Text").map(&:text).join('')
				end
				category.search("Affected_Resources").each do |cwe_resource|
					affected_resource = cwe_resource.content rescue nil
				end
				cwe_category = cwe_weakness_catalog.cwe_categories.create(cwe_cat_id: cwe_cat_id, name: name, cat_status: cat_status, desc: desc, extended_desc: extended_desc, liklihood_of_exploits: likelihood_of_exploit, affected_resource: affected_resource)

				category.search("Relationship").each do |cwe_relationship|
					relationship_view_id = ""
					ordinal = ""
					target_form = ""
					nature = ""
					target_id = ""
					cwe_relationship.search("Relationship_View_ID").each do |relationship_view|	
						relationship_view_id = relationship_view.content rescue nil
						ordinal = relationship_view[:Ordinal] rescue nil
					end
					cwe_relationship.search("Relationship_Target_Form").each do |relationship_target_form|
						target_form = relationship_target_form.content rescue nil
					end
					cwe_relationship.search("Relationship_Nature").each do |relationship_nature|
						nature = relationship_nature.content rescue nil
					end
					cwe_relationship.search("Relationship_Target_ID").each do |relationship_target_id|
						target_id = relationship_target_id.content rescue nil
					end
					comment = cwe_relationship.search("comment()")
					cwe_category.cwe_relationships.create(relationship_view_id: relationship_view_id, ordinal: ordinal, target_form: target_form, nature: nature, target_id: target_id, comment: comment)
				end

				category.search("Taxonomy_Mapping").each do |cwe_taxonomy|
					mapped_taxonomy_name = cwe_taxonomy[:Mapped_Taxonomy_Name] rescue nil
					mapped_node_name = ""
					mapped_node_id = ""
					mapping_fit = ""
					cwe_taxonomy.search("Mapped_Node_Name").each do |cwe_node_name|
						mapped_node_name = cwe_node_name.content rescue nil
					end
					cwe_taxonomy.search("Mapped_Node_ID").each do |cwe_node_id|
						mapped_node_id = cwe_node_id.content rescue nil
					end
					cwe_taxonomy.search("Mapping_Fit").each do |cwe_fit|
						mapping_fit = cwe_fit.content rescue nil
					end
					cwe_category.cwe_taxonomies.create(mapped_taxonomy_name: mapped_taxonomy_name, mapped_node_name: mapped_node_name, mapped_node_id: mapped_node_id, mapping_fit: mapping_fit)
				end

				cwe_content_history_cat = cwe_category.cwe_content_histories.create

				category.search("Modification").each do |cwe_modification|
					modification_source = cwe_modification[:Modification_Source]
					modifier = ""
					modifier_org = ""
					modification_date = ""
					modification_comment = ""
					cwe_modification.search("Modifier").each do |cwe_modifier|
						modifier = cwe_modifier.content rescue nil
					end
					cwe_modification.search("Modifier_Organization").each do |cwe_modifier_organization|
						modifier_org = cwe_modifier_organization.content rescue nil
					end
					cwe_modification.search("Modification_Date").each do |cwe_modification_date|
						modification_date = cwe_modification_date.content rescue nil
					end
					cwe_modification.search("Modification_Comment").each do |cwe_modification_comment|
						modification_comment = cwe_modification_comment.content rescue nil
					end
					cwe_content_history_cat.cwe_modifications.create(modification_source: modification_source, modifier: modifier, modifier_org: modifier_org, modification_date: modification_date, modification_comment: modification_comment)
				end

				category.search("Previous_Entry_Name").each do |previous_entry_name|
					name_change_date = previous_entry_name[:Name_Change_Date] rescue nil
					value = previous_entry_name.content rescue nil
					cwe_content_history_cat.cwe_prev_entry_names.create(name_change_date: name_change_date, value: value)
				end

				category.search("Submission").each do |submission|
					submission_source = submission[:Submission_Source] rescue nil
					submitter = ""
					submission_date = ""
					submission.search("Submitter").each do |cwe_submitter|
						submitter = cwe_submitter.content rescue nil
					end
					submission.search("Submission_Date").each do |cwe_submission_date|
						submission_date = cwe_submission_date.content rescue nil
					end
					cwe_content_history_cat.cwe_submissions.create(submission_source: submission_source, submitter: submitter, submission_date: submission_date)
				end

				category.search("Time_of_Introduction").each do |cwe_time_of_intro|
					intro_phase = cwe_time_of_intro.search("Introductory_Phase").map(&:text).join(',')
					cwe_category.cwe_time_of_intros.create(intro_phase: intro_phase)
				end

				category.search("Applicable_Platforms").each do |cwe_platform|
					language_name = ""
					language_class = ""
					note = ""
					cwe_platform.search("Architectural_Paradigm").each do |cwe_paradigm|
						prevalence = cwe_paradigm[:Prevalence]
						name = cwe_paradigm[:Architectural_Paradigm_Name]
						cwe_category.cwe_architechtural_paradigms.create(prevalence: prevalence, name: name)
					end
					cwe_platform.search("Languages").each do |cwe_language_info|
						cwe_language_info.search("Language").each do |cwe_language|
							language_name = cwe_language[:Language_Name] rescue nil
						end
						cwe_language_info.search("Language_Class").each do |cwe_language_class|
							language_class = cwe_language_class[:Language_Class_Description] rescue nil
						end
					end
					cwe_platform.search("Platform_Notes").each do |cwe_note|
						note = cwe_note.search("Text").map(&:text).join('')
					end
					cwe_category.cwe_languages.create(language_name: language_name, language_class: language_class, note: note)
					cwe_platform.search("Technology_Class").each do |cwe_tech_class|
						prevalence = cwe_tech_class[:Prevalence] rescue nil
						name = cwe_tech_class[:Technology_Name] rescue nil
						cwe_category.cwe_technology_classes.create(prevalence: prevalence, name: name)
					end
				end

				category.search("Mitigation").each do |cwe_mitigation|
					mitigation_id = cwe_mitigation[:Mitigation_ID] rescue nil
					mitigation_phase = ""
					mitigation_strategy = ""
					desc = ""
					cwe_mitigation.search("Mitigation_Phase").each do |cwe_mitigation_phase|
						mitigation_phase = cwe_mitigation_phase.content rescue nil
					end
					cwe_mitigation.search("Mitigation_Strategy").each do |cwe_mitigation_strategy|
						mitigation_strategy = cwe_mitigation_strategy.content rescue nil
					end
					cwe_mitigation.search("Mitigation_Description").each do |cwe_mitigation_desc|
						desc = cwe_mitigation_desc.search("Text").map(&:text).join('')
					end
					cwe_category.cwe_mitigations.create(mitigation_id: mitigation_id, mitigation_phase: mitigation_phase, mitigation_strategy: mitigation_strategy, desc: desc)
				end

				category.search("Related_Attack_Pattern").each do |cwe_attack_pattern|
					capec_version = cwe_attack_pattern[:CAPEC_Version] rescue nil
					capec_id = ""
					cwe_attack_pattern.search("CAPEC_ID").each do |cwe_capec|
						capec_id = cwe_capec.content rescue nil
					end
					cwe_category.cwe_related_attack_patterns.create(capec_version: capec_version, capec_id: capec_id)
				end

				category.search("Demonstrative_Example").each do |cwe_dx|
					dx_id = cwe_dx[:Demonstrative_Example_ID] rescue nil
					intro_text = ""
					desc = ""
					block_nature = ""
					code_example_lang = ""
					code_block = ""
					cwe_dx.search("Intro_Text").each do |cwe_intro_text|
						intro_text = cwe_intro_text.content rescue nil
					end
					cwe_example = cwe_category.cwe_demonstrative_examples.create(dx_id: dx_id, intro_text: intro_text)
					cwe_dx.search("Example_Body").each do |cwe_example_body|
						cwe_example_body.search("Block").each do |cwe_block|
							block_nature = cwe_block[:Block_Nature] rescue nil
							unless block_nature.blank?
								code_block = cwe_block.content
								if !cwe_block.next_element.blank? && cwe_block.next_element[:Block_Nature].blank?
									desc = cwe_block.next_element.text
								end
								code_example_lang = cwe_block.search("Code_Example_Language").map(&:text).join('')
								cwe_example.code_blocks.create(code_block: code_block, desc: desc, code_example_lang: code_example_lang, block_nature: block_nature)
							end
						end
					end
				end

				category.search("Common_Consequence").each do |cwe_common_consequence|
					consequence_scope = cwe_common_consequence.search("Consequence_Scope").map(&:text).join(',')
					technical_impact = cwe_common_consequence.search("Consequence_Technical_Impact").map(&:text).join(',')
					note = ""
					cwe_common_consequence.search("Consequence_Note").each do |cwe_consequence_note|
						note = cwe_consequence_note.search("Text").map(&:text).join('')
					end
					cwe_category.cwe_common_consequences.create(consequence_scope: consequence_scope, technical_impact: technical_impact, note: note)
				end

				category.search("Reference").each do |cwe_reference|
					ref_id = cwe_reference[:Reference_ID] rescue nil
					local_ref_id = cwe_reference[:Local_Reference_ID] rescue nil
					ref_author = cwe_reference.search("Reference_Author").map(&:text).join(',')
					ref_title = ""
					ref_section = ""
					ref_edition = ""
					ref_publisher = ""
					ref_pubdate = ""
					ref_date = ""
					ref_link = ""
					cwe_reference.search("Reference_Title").each do |cwe_ref_title|
						ref_title = cwe_ref_title.content rescue nil
					end
					cwe_reference.search("Reference_Section").each do |cwe_ref_section|
						ref_section = cwe_ref_section.content rescue nil
					end
					cwe_reference.search("Reference_Edition").each do |cwe_ref_edition|
						ref_edition = cwe_ref_edition.content rescue nil
					end
					cwe_reference.search("Reference_Publisher").each do |cwe_ref_pub|
						ref_publisher = cwe_ref_pub.content rescue nil
					end
					cwe_reference.search("Reference_PubDate").each do |cwe_ref_pubdate|
						ref_pubdate = cwe_ref_pubdate.content rescue nil
					end
					cwe_reference.search("Reference_Date").each do |cwe_ref_date|
						ref_date = cwe_ref_date.content rescue nil
					end
					cwe_reference.search("Reference_Link").each do |cwe_ref_link|
						ref_link = cwe_ref_link.content rescue nil
					end
					cwe_category.cwe_references.create(ref_id: ref_id, ref_author: ref_author, ref_title: ref_title, ref_section: ref_section, ref_edition: ref_edition, ref_publisher: ref_publisher, ref_pubdate: ref_pubdate, ref_date: ref_date, ref_link: ref_link, local_ref_id: local_ref_id)
				end

				category.search("White_Box_Definition").each do |cwe_white_box_def|
					definition = cwe_white_box_def.content rescue nil
					cwe_category.cwe_white_box_defs.create(definition_block: definition)
				end

				category.search("Observed_Example").each do |cwe_observed_example|
					observed_example_ref = ""
					desc = ""
					cwe_observed_example.search("Observed_Example_Reference").each do |cwe_exmpl_ref|
						observed_example_ref = cwe_exmpl_ref.content rescue nil
					end
					cwe_observed_example.search("Observed_Example_Description").each do |cwe_desc|
						desc = cwe_desc.content rescue nil
					end
					cwe_category.cwe_observed_examples.create(observed_example_ref: observed_example_ref, desc: desc)
				end

				category.search("Detection_Method").each do |cwe_detection_method|
					method_name = ""
					method_desc = ""
					method_effectiveness = ""
					cwe_detection_method.search("Method_Name").each do |cwe_method_name|
						method_name = cwe_method_name.content rescue nil
					end
					cwe_detection_method.search("Method_Description").each do |cwe_method_desc|
						method_desc = cwe_method_desc.content
					end
					cwe_detection_method.search("Method_Effectiveness").each do |cwe_method_effectiveness|
						method_effectiveness = cwe_method_effectiveness.content rescue nil
					end
					cwe_category.cwe_detection_methods.create(method_name: method_name, method_desc: method_desc, method_effectiveness: method_effectiveness)
				end

				category.search("Theoretical_Note").each do |cwe_theory_note|
					note = cwe_theory_note.content rescue nil
					cwe_category.cwe_theoritical_notes.create(note: note)
				end

				category.search("Research_Gap").each do |cwe_research_gap|
					research_gap = cwe_research_gap.search("Text").map(&:text).join(',')
					cwe_category.cwe_research_gaps.create(research_gap: research_gap)
				end

				category.search("Functional_Area").each do |cwe_functional_area|
					functional_area = cwe_functional_area.content rescue nil
					cwe_category.cwe_functional_areas.create(functional_area: functional_area)
				end

				category.search("Mode_of_Introduction").each do |cwe_mode_of_intro|
					mode_of_intro = cwe_mode_of_intro.content rescue nil
					cwe_category.cwe_mode_of_intros.create(mode_of_intro: mode_of_intro)
				end
			end

			node.search("Weakness").each do |weakness|
				weakness_id = weakness[:ID] rescue nil
				name = weakness[:Name] rescue nil
				weakness_abstraction = weakness[:Weakness_Abstraction] rescue nil
				weakness_status = weakness[:Status] rescue nil
				desc_summary = ""
				ext_desc = ""
				terminology_note = ""
				likelihood_of_exploit = ""
				background_details = ""
				casual_nature = ""
				affected_resource = ""
				other_notes = ""
				weakness.search("Description_Summary").each do |cwe_desc_summary|
					desc_summary = cwe_desc_summary.content rescue nil
				end
				weakness.search("Extended_Description").each do |cwe_ext_desc|
					ext_desc = cwe_ext_desc.search("Text").map(&:text).join('\n')
				end
				weakness.search("Terminology_Note").each do |cwe_terminology_note|
					terminology_note = cwe_terminology_note.search("Text").map(&:text).join('')
				end
				weakness.search("Likelihood_of_Exploit").each do |cwe_exploit|
					likelihood_of_exploit = cwe_exploit.content rescue nil
				end
				weakness.search("Background_Detail").each do |cwe_background_detail|
					background_details = cwe_background_detail.search("Text").map(&:text).join('')
				end
				weakness.search("Causal_Nature").each do |cwe_casual_nature|
					casual_nature = cwe_casual_nature.content rescue nil
				end
				weakness.search("Affected_Resources").each do |cwe_resource|
					affected_resource = cwe_resource.content rescue nil
				end
				weakness.search("Other_Notes").each do |cwe_other_note|
					cwe_other_note.search("Note").each do |cwe_note|
						other_notes = cwe_note.search("Text").map(&:text).join('')
					end
				end
				cwe_weakness = cwe_weakness_catalog.cwe_weaknesses.create(weakness_id: weakness_id, name: name, weakness_abstruction: weakness_abstraction, desc_summary: desc_summary, ext_desc: ext_desc, weakness_status: weakness_status, terminology_note: terminology_note, liklihood_of_exploit: likelihood_of_exploit, background_details: background_details, casual_nature: casual_nature, affected_resource: affected_resource, other_notes: other_notes)

				weakness.search("Relationship").each do |cwe_relationship_weakness|
					relationship_view_id = ""
					ordinal = ""
					target_form = ""
					nature = ""
					target_id = ""
					cwe_relationship_weakness.search("Relationship_View_ID").each do |relationship_view|	
						relationship_view_id = relationship_view.content rescue nil
						ordinal = relationship_view[:Ordinal] rescue nil
					end
					cwe_relationship_weakness.search("Relationship_Target_Form").each do |relationship_target_form|
						target_form = relationship_target_form.content rescue nil
					end
					cwe_relationship_weakness.search("Relationship_Nature").each do |relationship_nature|
						nature = relationship_nature.content rescue nil
					end
					cwe_relationship_weakness.search("Relationship_Target_ID").each do |relationship_target_id|
						target_id = relationship_target_id.content rescue nil
					end
					comment = cwe_relationship_weakness.search("comment()")
					cwe_weakness.cwe_relationships.create(relationship_view_id: relationship_view_id, ordinal: ordinal, target_form: target_form, nature: nature, target_id: target_id, comment: comment)
				end

				weakness.search("Relationship_Note").each do |relationship_note|
					note = relationship_note.search("Text").map(&:text).join('') rescue nil
					cwe_weakness.cwe_relationship_notes.create(note: note)
				end

				weakness.search("Applicable_Platforms").each do |cwe_platform|
					language_name = ""
					language_class = ""
					note = ""
					cwe_platform.search("Architectural_Paradigm").each do |cwe_paradigm|
						prevalence = cwe_paradigm[:Prevalence]
						name = cwe_paradigm[:Architectural_Paradigm_Name]
						cwe_weakness.cwe_architechtural_paradigms.create(prevalence: prevalence, name: name)
					end
					cwe_platform.search("Languages").each do |cwe_language_info|
						cwe_language_info.search("Language").each do |cwe_language|
							language_name = cwe_language[:Language_Name] rescue nil
						end
						cwe_language_info.search("Language_Class").each do |cwe_language_class|
							language_class = cwe_language_class[:Language_Class_Description] rescue nil
						end
					end
					cwe_platform.search("Platform_Notes").each do |cwe_note|
						note = cwe_note.search("Text").map(&:text).join('')
					end
					cwe_weakness.cwe_languages.create(language_name: language_name, language_class: language_class, note: note)
					cwe_platform.search("Technology_Class").each do |cwe_tech_class|
						prevalence = cwe_tech_class[:Prevalence] rescue nil
						name = cwe_tech_class[:Technology_Name] rescue nil
						cwe_weakness.cwe_technology_classes.create(prevalence: prevalence, name: name)
					end
				end

				weakness.search("Maintenance_Note").each do |cwe_note|
					note = cwe_note.search("Text").map(&:text).join('')
					image_location = ""
					image_title = ""
					cwe_note.search("Image_Location").each do |cwe_image_location|
						image_location = cwe_image_location.content rescue nil
					end
					cwe_note.search("Image_Title").each do |cwe_image_title|
						image_title = cwe_image_title.content rescue nil
					end
					cwe_weakness.cwe_maintenance_notes.create(note: note, image_location: image_location, image_title: image_title)
				end

				weakness.search("Alternate_Term").each do |cwe_alternate_term|
					term = ""
					desc = ""
					cwe_alternate_term.search("Term").each do |cwe_term|
						term = cwe_term.content rescue nil
					end
					cwe_alternate_term.search("Alternate_Term_Description").each do |cwe_desc|
						desc = cwe_desc.search("Text").map(&:text).join('')
					end
					cwe_weakness.cwe_alternate_terms.create(term: term, desc: desc)
				end

				weakness.search("Weakness_Ordinality").each do |cwe_weakness_ordinality|
					ordinality = ""
					cwe_weakness_ordinality.search("Ordinality").each do |cwe_ordinality|
						ordinality = cwe_ordinality.content rescue nil
					end
					cwe_weakness.cwe_weakness_ordinalities.create(ordinality: ordinality)
				end

				weakness.search("Time_of_Introduction").each do |cwe_time_of_intro|
					intro_phase = cwe_time_of_intro.search("Introductory_Phase").map(&:text).join(',')
					cwe_weakness.cwe_time_of_intros.create(intro_phase: intro_phase)
				end

				weakness.search("Common_Consequence").each do |cwe_common_consequence|
					consequence_scope = cwe_common_consequence.search("Consequence_Scope").map(&:text).join(',')
					technical_impact = cwe_common_consequence.search("Consequence_Technical_Impact").map(&:text).join(',')
					note = ""
					cwe_common_consequence.search("Consequence_Note").each do |cwe_consequence_note|
						note = cwe_consequence_note.search("Text").map(&:text).join('')
					end
					cwe_weakness.cwe_common_consequences.create(consequence_scope: consequence_scope, technical_impact: technical_impact, note: note)
				end

				weakness.search("Mitigation").each do |cwe_mitigation|
					mitigation_id = cwe_mitigation[:Mitigation_ID] rescue nil
					mitigation_phase = ""
					mitigation_strategy = ""
					desc = ""
					cwe_mitigation.search("Mitigation_Phase").each do |cwe_mitigation_phase|
						mitigation_phase = cwe_mitigation_phase.content rescue nil
					end
					cwe_mitigation.search("Mitigation_Strategy").each do |cwe_mitigation_strategy|
						mitigation_strategy = cwe_mitigation_strategy.content rescue nil
					end
					cwe_mitigation.search("Mitigation_Description").each do |cwe_mitigation_desc|
						desc = cwe_mitigation_desc.search("Text").map(&:text).join('')
					end
					cwe_weakness.cwe_mitigations.create(mitigation_id: mitigation_id, mitigation_phase: mitigation_phase, mitigation_strategy: mitigation_strategy, desc: desc)
				end

				weakness.search("Demonstrative_Example").each do |cwe_dx|
					dx_id = cwe_dx[:Demonstrative_Example_ID] rescue nil
					intro_text = ""
					desc = ""
					block_nature = ""
					code_example_lang = ""
					code_block = ""
					cwe_dx.search("Intro_Text").each do |cwe_intro_text|
						intro_text = cwe_intro_text.content rescue nil
					end
					cwe_example = cwe_weakness.cwe_demonstrative_examples.create(dx_id: dx_id, intro_text: intro_text)
					cwe_dx.search("Example_Body").each do |cwe_example_body|
						cwe_example_body.search("Block").each do |cwe_block|
							block_nature = cwe_block[:Block_Nature] rescue nil
							unless block_nature.blank?
								code_block = cwe_block.content
								if !cwe_block.next_element.blank? && cwe_block.next_element[:Block_Nature].blank?
									desc = cwe_block.next_element.text
								end
								code_example_lang = cwe_block.search("Code_Example_Language").map(&:text).join('')
								cwe_example.code_blocks.create(code_block: code_block, desc: desc, code_example_lang: code_example_lang, block_nature: block_nature)
							end
						end
					end
				end

				weakness.search("Observed_Example").each do |cwe_observed_example|
					observed_example_ref = ""
					desc = ""
					cwe_observed_example.search("Observed_Example_Reference").each do |cwe_exmpl_ref|
						observed_example_ref = cwe_exmpl_ref.content rescue nil
					end
					cwe_observed_example.search("Observed_Example_Description").each do |cwe_desc|
						desc = cwe_desc.content rescue nil
					end
					cwe_weakness.cwe_observed_examples.create(observed_example_ref: observed_example_ref, desc: desc)
				end

				weakness.search("Detection_Method").each do |cwe_detection_method|
					method_name = ""
					method_desc = ""
					method_effectiveness = ""
					method_id = cwe_detection_method[:Detection_Method_ID] rescue nil
					cwe_detection_method.search("Method_Name").each do |cwe_method_name|
						method_name = cwe_method_name.content rescue nil
					end
					cwe_detection_method.search("Method_Description").each do |cwe_method_desc|
						method_desc = cwe_method_desc.content
					end
					cwe_detection_method.search("Method_Effectiveness").each do |cwe_method_effectiveness|
						method_effectiveness = cwe_method_effectiveness.content rescue nil
					end
					cwe_weakness.cwe_detection_methods.create(method_name: method_name, method_desc: method_desc, method_effectiveness: method_effectiveness)
				end

				weakness.search("Taxonomy_Mapping").each do |cwe_taxonomy|
					mapped_taxonomy_name = cwe_taxonomy[:Mapped_Taxonomy_Name] rescue nil
					mapped_node_name = ""
					mapped_node_id = ""
					mapping_fit = ""
					cwe_taxonomy.search("Mapped_Node_Name").each do |cwe_node_name|
						mapped_node_name = cwe_node_name.content rescue nil
					end
					cwe_taxonomy.search("Mapped_Node_ID").each do |cwe_node_id|
						mapped_node_id = cwe_node_id.content rescue nil
					end
					cwe_taxonomy.search("Mapping_Fit").each do |cwe_fit|
						mapping_fit = cwe_fit.content rescue nil
					end
					cwe_weakness.cwe_taxonomies.create(mapped_taxonomy_name: mapped_taxonomy_name, mapped_node_name: mapped_node_name, mapped_node_id: mapped_node_id, mapping_fit: mapping_fit)
				end

				weakness.search("Reference").each do |cwe_reference|
					ref_id = cwe_reference[:Reference_ID] rescue nil
					local_ref_id = cwe_reference[:Local_Reference_ID] rescue nil
					ref_author = cwe_reference.search("Reference_Author").map(&:text).join(',')
					ref_title = ""
					ref_section = ""
					ref_edition = ""
					ref_publisher = ""
					ref_pubdate = ""
					ref_date = ""
					ref_link = ""
					cwe_reference.search("Reference_Title").each do |cwe_ref_title|
						ref_title = cwe_ref_title.content rescue nil
					end
					cwe_reference.search("Reference_Section").each do |cwe_ref_section|
						ref_section = cwe_ref_section.content rescue nil
					end
					cwe_reference.search("Reference_Edition").each do |cwe_ref_edition|
						ref_edition = cwe_ref_edition.content rescue nil
					end
					cwe_reference.search("Reference_Publisher").each do |cwe_ref_pub|
						ref_publisher = cwe_ref_pub.content rescue nil
					end
					cwe_reference.search("Reference_PubDate").each do |cwe_ref_pubdate|
						ref_pubdate = cwe_ref_pubdate.content rescue nil
					end
					cwe_reference.search("Reference_Date").each do |cwe_ref_date|
						ref_date = cwe_ref_date.content rescue nil
					end
					cwe_reference.search("Reference_Link").each do |cwe_ref_link|
						ref_link = cwe_ref_link.content rescue nil
					end
					cwe_weakness.cwe_references.create(ref_id: ref_id, ref_author: ref_author, ref_title: ref_title, ref_section: ref_section, ref_edition: ref_edition, ref_publisher: ref_publisher, ref_pubdate: ref_pubdate, ref_date: ref_date, ref_link: ref_link, local_ref_id: local_ref_id)
				end

				cwe_content_history_weakness = cwe_weakness.cwe_content_histories.create

				weakness.search("Modification").each do |cwe_modification|
					modification_source = cwe_modification[:Modification_Source]
					modifier = ""
					modifier_org = ""
					modification_date = ""
					modification_comment = ""
					cwe_modification.search("Modifier").each do |cwe_modifier|
						modifier = cwe_modifier.content rescue nil
					end
					cwe_modification.search("Modifier_Organization").each do |cwe_modifier_organization|
						modifier_org = cwe_modifier_organization.content rescue nil
					end
					cwe_modification.search("Modification_Date").each do |cwe_modification_date|
						modification_date = cwe_modification_date.content rescue nil
					end
					cwe_modification.search("Modification_Comment").each do |cwe_modification_comment|
						modification_comment = cwe_modification_comment.content rescue nil
					end
					cwe_content_history_weakness.cwe_modifications.create(modification_source: modification_source, modifier: modifier, modifier_org: modifier_org, modification_date: modification_date, modification_comment: modification_comment)
				end

				weakness.search("Submission").each do |submission|
					submission_source = submission[:Submission_Source] rescue nil
					submitter = ""
					submission_date = ""
					submission.search("Submitter").each do |cwe_submitter|
						submitter = cwe_submitter.content rescue nil
					end
					submission.search("Submission_Date").each do |cwe_submission_date|
						submission_date = cwe_submission_date.content rescue nil
					end
					cwe_content_history_weakness.cwe_submissions.create(submission_source: submission_source, submitter: submitter, submission_date: submission_date)
				end

				weakness.search("Previous_Entry_Name").each do |previous_entry_name|
					name_change_date = previous_entry_name[:Name_Change_Date] rescue nil
					value = previous_entry_name.content rescue nil
					cwe_content_history_weakness.cwe_prev_entry_names.create(name_change_date: name_change_date, value: value)
				end

				weakness.search("Related_Attack_Pattern").each do |cwe_attack_pattern|
					capec_version = cwe_attack_pattern[:CAPEC_Version] rescue nil
					capec_id = ""
					cwe_attack_pattern.search("CAPEC_ID").each do |cwe_capec|
						capec_id = cwe_capec.content rescue nil
					end
					cwe_weakness.cwe_related_attack_patterns.create(capec_version: capec_version, capec_id: capec_id)
				end

				weakness.search("Theoretical_Note").each do |cwe_theory_note|
					note = cwe_theory_note.content rescue nil
					cwe_weakness.cwe_theoritical_notes.create(note: note)
				end

				weakness.search("Research_Gap").each do |cwe_research_gap|
					research_gap = cwe_research_gap.search("Text").map(&:text).join(',')
					cwe_weakness.cwe_research_gaps.create(research_gap: research_gap)
				end

				weakness.search("Functional_Area").each do |cwe_functional_area|
					functional_area = cwe_functional_area.content rescue nil
					cwe_weakness.cwe_functional_areas.create(functional_area: functional_area)
				end

				weakness.search("Mode_of_Introduction").each do |cwe_mode_of_intro|
					mode_of_intro = cwe_mode_of_intro.content rescue nil
					cwe_weakness.cwe_mode_of_intros.create(mode_of_intro: mode_of_intro)
				end
			end

			node.search("Compound_Element").each do |element|
				element_id = element[:ID] rescue nil
				name = element[:Name] rescue nil
				compound_element_abstraction = element[:Compound_Element_Abstraction] rescue nil
				compound_element_structure = element[:Compound_Element_Structure] rescue nil
				element_status = element[:Status] rescue nil
				desc_summary = ""
				ext_desc = ""
				likelihood_of_exploit = ""
				other_notes = ""
				affected_resource = ""
				casual_nature = ""
				relevant_property = ""
				element.search("Description").each do |cwe_desc|
					cwe_desc.search("Description_Summary").each do |cwe_desc_summary|
						desc_summary = cwe_desc_summary.content rescue nil
					end
					cwe_desc.search("Extended_Description").each do |cwe_ext_desc|
						ext_desc = cwe_ext_desc.search("Text").map(&:text).join('')
					end
				end
				element.search("Likelihood_of_Exploit").each do |cwe_likelihood_of_exploit|
					likelihood_of_exploit = cwe_likelihood_of_exploit.content rescue nil
				end
				element.search("Other_Notes").each do |cwe_other_note|
					cwe_other_note.search("Note").each do |cwe_note|
						other_notes = cwe_note.search("Text").map(&:text).join('')
					end
				end
				element.search("Affected_Resources").each do |cwe_resource|
					affected_resource = cwe_resource.content rescue nil
				end
				element.search("Causal_Nature").each do |cwe_casual_nature|
					casual_nature = cwe_casual_nature.content rescue nil
				end
				element.search("Relevant_Property").each do |cwe_relevant_property|
					relevant_property = cwe_relevant_property.content rescue nil
				end
				cwe_compound_element = cwe_weakness_catalog.cwe_compound_elements.create(element_id: element_id, name: name, compound_element_abstraction: compound_element_abstraction, compound_element_structure: compound_element_structure, element_status: element_status, desc_summary: desc_summary, ext_desc: ext_desc, likelihood_of_exploit: likelihood_of_exploit, other_notes: other_notes, affected_resource: affected_resource, casual_nature: casual_nature, relevant_property: relevant_property)

				element.search("Relationship").each do |cwe_relationship|
					relationship_view_id = ""
					ordinal = ""
					target_form = ""
					nature = ""
					target_id = ""
					cwe_relationship.search("Relationship_View_ID").each do |relationship_view|	
						relationship_view_id = relationship_view.content rescue nil
						ordinal = relationship_view[:Ordinal] rescue nil
					end
					cwe_relationship.search("Relationship_Target_Form").each do |relationship_target_form|
						target_form = relationship_target_form.content rescue nil
					end
					cwe_relationship.search("Relationship_Nature").each do |relationship_nature|
						nature = relationship_nature.content rescue nil
					end
					cwe_relationship.search("Relationship_Target_ID").each do |relationship_target_id|
						target_id = relationship_target_id.content rescue nil
					end
					comment = cwe_relationship.search("comment()")
					cwe_compound_element.cwe_relationships.create(relationship_view_id: relationship_view_id, ordinal: ordinal, target_form: target_form, nature: nature, target_id: target_id, comment: comment)
				end

				element.search("Relationship_Note").each do |relationship_note|
					note = relationship_note.search("Text").map(&:text).join('') rescue nil
					cwe_compound_element.cwe_relationship_notes.create(note: note)
				end

				element.search("Applicable_Platforms").each do |cwe_platform|
					language_name = ""
					language_class = ""
					note = ""
					cwe_platform.search("Architectural_Paradigm").each do |cwe_paradigm|
						prevalence = cwe_paradigm[:Prevalence]
						name = cwe_paradigm[:Architectural_Paradigm_Name]
						cwe_compound_element.cwe_architechtural_paradigms.create(prevalence: prevalence, name: name)
					end
					cwe_platform.search("Languages").each do |cwe_language_info|
						cwe_language_info.search("Language").each do |cwe_language|
							language_name = cwe_language[:Language_Name] rescue nil
						end
						cwe_language_info.search("Language_Class").each do |cwe_language_class|
							language_class = cwe_language_class[:Language_Class_Description] rescue nil
						end
					end
					cwe_platform.search("Platform_Notes").each do |cwe_note|
						note = cwe_note.search("Text").map(&:text).join('')
					end
					cwe_compound_element.cwe_languages.create(language_name: language_name, language_class: language_class, note: note)
					cwe_platform.search("Technology_Class").each do |cwe_tech_class|
						prevalence = cwe_tech_class[:Prevalence] rescue nil
						name = cwe_tech_class[:Technology_Name] rescue nil
						cwe_compound_element.cwe_technology_classes.create(prevalence: prevalence, name: name)
					end
				end

				element.search("Alternate_Term").each do |cwe_alternate_term|
					term = ""
					desc = ""
					cwe_alternate_term.search("Term").each do |cwe_term|
						term = cwe_term.content rescue nil
					end
					cwe_alternate_term.search("Alternate_Term_Description").each do |cwe_desc|
						desc = cwe_desc.search("Text").map(&:text).join('')
					end
					cwe_compound_element.cwe_alternate_terms.create(term: term, desc: desc)
				end

				element.search("Time_of_Introduction").each do |cwe_time_of_intro|
					intro_phase = cwe_time_of_intro.search("Introductory_Phase").map(&:text).join(',')
					cwe_compound_element.cwe_time_of_intros.create(intro_phase: intro_phase)
				end

				element.search("Common_Consequence").each do |cwe_common_consequence|
					consequence_scope = cwe_common_consequence.search("Consequence_Scope").map(&:text).join(',')
					technical_impact = cwe_common_consequence.search("Consequence_Technical_Impact").map(&:text).join(',')
					note = ""
					cwe_common_consequence.search("Consequence_Note").each do |cwe_consequence_note|
						note = cwe_consequence_note.search("Text").map(&:text).join('')
					end
					cwe_compound_element.cwe_common_consequences.create(consequence_scope: consequence_scope, technical_impact: technical_impact, note: note)
				end

				element.search("Detection_Method").each do |cwe_detection_method|
					method_name = ""
					method_desc = ""
					method_effectiveness = ""
					cwe_detection_method.search("Method_Name").each do |cwe_method_name|
						method_name = cwe_method_name.content rescue nil
					end
					cwe_detection_method.search("Method_Description").each do |cwe_method_desc|
						method_desc = cwe_method_desc.content
					end
					cwe_detection_method.search("Method_Effectiveness").each do |cwe_method_effectiveness|
						method_effectiveness = cwe_method_effectiveness.content rescue nil
					end
					cwe_compound_element.cwe_detection_methods.create(method_name: method_name, method_desc: method_desc, method_effectiveness: method_effectiveness)
				end

				element.search("Mitigation").each do |cwe_mitigation|
					mitigation_id = cwe_mitigation[:Mitigation_ID] rescue nil
					mitigation_phase = ""
					mitigation_strategy = ""
					desc = ""
					cwe_mitigation.search("Mitigation_Phase").each do |cwe_mitigation_phase|
						mitigation_phase = cwe_mitigation_phase.content rescue nil
					end
					cwe_mitigation.search("Mitigation_Strategy").each do |cwe_mitigation_strategy|
						mitigation_strategy = cwe_mitigation_strategy.content rescue nil
					end
					cwe_mitigation.search("Mitigation_Description").each do |cwe_mitigation_desc|
						desc = cwe_mitigation_desc.search("Text").map(&:text).join('')
					end
					cwe_compound_element.cwe_mitigations.create(mitigation_id: mitigation_id, mitigation_phase: mitigation_phase, mitigation_strategy: mitigation_strategy, desc: desc)
				end

				element.search("Demonstrative_Example").each do |cwe_dx|
					dx_id = cwe_dx[:Demonstrative_Example_ID] rescue nil
					intro_text = ""
					desc = ""
					block_nature = ""
					code_example_lang = ""
					code_block = ""
					cwe_dx.search("Intro_Text").each do |cwe_intro_text|
						intro_text = cwe_intro_text.content rescue nil
					end
					cwe_example = cwe_compound_element.cwe_demonstrative_examples.create(dx_id: dx_id, intro_text: intro_text)
					cwe_dx.search("Example_Body").each do |cwe_example_body|
						cwe_example_body.search("Block").each do |cwe_block|
							block_nature = cwe_block[:Block_Nature] rescue nil
							unless block_nature.blank?
								code_block = cwe_block.content
								if !cwe_block.next_element.blank? && cwe_block.next_element[:Block_Nature].blank?
									desc = cwe_block.next_element.text
								end
								code_example_lang = cwe_block.search("Code_Example_Language").map(&:text).join('')
								cwe_example.code_blocks.create(code_block: code_block, desc: desc, code_example_lang: code_example_lang, block_nature: block_nature)
							end
						end
					end
				end

				element.search("Observed_Example").each do |cwe_observed_example|
					observed_example_ref = ""
					desc = ""
					cwe_observed_example.search("Observed_Example_Reference").each do |cwe_exmpl_ref|
						observed_example_ref = cwe_exmpl_ref.content rescue nil
					end
					cwe_observed_example.search("Observed_Example_Description").each do |cwe_desc|
						desc = cwe_desc.content rescue nil
					end
					cwe_compound_element.cwe_observed_examples.create(observed_example_ref: observed_example_ref, desc: desc)
				end

				element.search("Taxonomy_Mapping").each do |cwe_taxonomy|
					mapped_taxonomy_name = cwe_taxonomy[:Mapped_Taxonomy_Name] rescue nil
					mapped_node_name = ""
					mapped_node_id = ""
					mapping_fit = ""
					cwe_taxonomy.search("Mapped_Node_Name").each do |cwe_node_name|
						mapped_node_name = cwe_node_name.content rescue nil
					end
					cwe_taxonomy.search("Mapped_Node_ID").each do |cwe_node_id|
						mapped_node_id = cwe_node_id.content rescue nil
					end
					cwe_taxonomy.search("Mapping_Fit").each do |cwe_fit|
						mapping_fit = cwe_fit.content rescue nil
					end
					cwe_compound_element.cwe_taxonomies.create(mapped_taxonomy_name: mapped_taxonomy_name, mapped_node_name: mapped_node_name, mapped_node_id: mapped_node_id, mapping_fit: mapping_fit)
				end

				element.search("Reference").each do |cwe_reference|
					ref_id = cwe_reference[:Reference_ID] rescue nil
					local_ref_id = cwe_reference[:Local_Reference_ID] rescue nil
					ref_author = cwe_reference.search("Reference_Author").map(&:text).join(',')
					ref_title = ""
					ref_section = ""
					ref_edition = ""
					ref_publisher = ""
					ref_pubdate = ""
					ref_date = ""
					ref_link = ""
					cwe_reference.search("Reference_Title").each do |cwe_ref_title|
						ref_title = cwe_ref_title.content rescue nil
					end
					cwe_reference.search("Reference_Section").each do |cwe_ref_section|
						ref_section = cwe_ref_section.content rescue nil
					end
					cwe_reference.search("Reference_Edition").each do |cwe_ref_edition|
						ref_edition = cwe_ref_edition.content rescue nil
					end
					cwe_reference.search("Reference_Publisher").each do |cwe_ref_pub|
						ref_publisher = cwe_ref_pub.content rescue nil
					end
					cwe_reference.search("Reference_PubDate").each do |cwe_ref_pubdate|
						ref_pubdate = cwe_ref_pubdate.content rescue nil
					end
					cwe_reference.search("Reference_Date").each do |cwe_ref_date|
						ref_date = cwe_ref_date.content rescue nil
					end
					cwe_reference.search("Reference_Link").each do |cwe_ref_link|
						ref_link = cwe_ref_link.content rescue nil
					end
					cwe_compound_element.cwe_references.create(ref_id: ref_id, ref_author: ref_author, ref_title: ref_title, ref_section: ref_section, ref_edition: ref_edition, ref_publisher: ref_publisher, ref_pubdate: ref_pubdate, ref_date: ref_date, ref_link: ref_link, local_ref_id: local_ref_id)
				end

				element.search("Related_Attack_Pattern").each do |cwe_attack_pattern|
					capec_version = cwe_attack_pattern[:CAPEC_Version] rescue nil
					capec_id = ""
					cwe_attack_pattern.search("CAPEC_ID").each do |cwe_capec|
						capec_id = cwe_capec.content rescue nil
					end
					cwe_compound_element.cwe_related_attack_patterns.create(capec_version: capec_version, capec_id: capec_id)
				end

				cwe_content_history_element = cwe_compound_element.cwe_content_histories.create

				element.search("Modification").each do |cwe_modification|
					modification_source = cwe_modification[:Modification_Source]
					modifier = ""
					modifier_org = ""
					modification_date = ""
					modification_comment = ""
					cwe_modification.search("Modifier").each do |cwe_modifier|
						modifier = cwe_modifier.content rescue nil
					end
					cwe_modification.search("Modifier_Organization").each do |cwe_modifier_organization|
						modifier_org = cwe_modifier_organization.content rescue nil
					end
					cwe_modification.search("Modification_Date").each do |cwe_modification_date|
						modification_date = cwe_modification_date.content rescue nil
					end
					cwe_modification.search("Modification_Comment").each do |cwe_modification_comment|
						modification_comment = cwe_modification_comment.content rescue nil
					end
					cwe_content_history_element.cwe_modifications.create(modification_source: modification_source, modifier: modifier, modifier_org: modifier_org, modification_date: modification_date, modification_comment: modification_comment)
				end

				element.search("Previous_Entry_Name").each do |previous_entry_name|
					name_change_date = previous_entry_name[:Name_Change_Date] rescue nil
					value = previous_entry_name.content rescue nil
					cwe_content_history_element.cwe_prev_entry_names.create(name_change_date: name_change_date, value: value)
				end

				element.search("Submission").each do |submission|
					submission_source = submission[:Submission_Source] rescue nil
					submitter = ""
					submission_date = ""
					submission.search("Submitter").each do |cwe_submitter|
						submitter = cwe_submitter.content rescue nil
					end
					submission.search("Submission_Date").each do |cwe_submission_date|
						submission_date = cwe_submission_date.content rescue nil
					end
					cwe_content_history_element.cwe_submissions.create(submission_source: submission_source, submitter: submitter, submission_date: submission_date)
				end

				element.search("Theoretical_Note").each do |cwe_theory_note|
					note = cwe_theory_note.content rescue nil
					cwe_compound_element.cwe_theoritical_notes.create(note: note)
				end

				element.search("Research_Gap").each do |cwe_research_gap|
					research_gap = cwe_research_gap.search("Text").map(&:text).join(',')
					cwe_compound_element.cwe_research_gaps.create(research_gap: research_gap)
				end

				element.search("Functional_Area").each do |cwe_functional_area|
					functional_area = cwe_functional_area.content rescue nil
					cwe_compound_element.cwe_functional_areas.create(functional_area: functional_area)
				end

				element.search("Weakness_Ordinality").each do |cwe_weakness_ordinality|
					ordinality = ""
					cwe_weakness_ordinality.search("Ordinality").each do |cwe_ordinality|
						ordinality = cwe_ordinality.content rescue nil
					end
					cwe_compound_element.cwe_weakness_ordinalities.create(ordinality: ordinality)
				end

				element.search("Mode_of_Introduction").each do |cwe_mode_of_intro|
					mode_of_intro = cwe_mode_of_intro.content rescue nil
					cwe_compound_element.cwe_mode_of_intros.create(mode_of_intro: mode_of_intro)
				end
			end
		end
	end
end
