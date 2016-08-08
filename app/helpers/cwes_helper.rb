module CwesHelper
	def add_relationship_type_image(relationship_type)
		case relationship_type
		when "Weakness"
			"/assets/weakness.gif"
		when "Category"
			"/assets/category.gif"
		when "View"
			"/assets/view.gif"
		when "Compound_Element"
			"/assets/compound_element.gif"
		end
	end

	def find_relation_name(relationship_type, relation_id)
		link = ""
		case relationship_type
		when "Weakness"
			name = CweWeakness.find_by(weakness_id: relation_id)
			link = link_to name.name, cwe_path(name.weakness_id)
		when "Category"
			name = CweCategory.find_by(cwe_cat_id: relation_id)
			link = link_to name.name, cwe_category_path(name.cwe_cat_id)
		when "View"
			name = CweViews.find_by(view_id: relation_id)
			link = link_to name.name, cwe_category_path(name.cwe_cat_id)
		when "Compound_Element"
			name = CweCompoundElement.find_by(element_id: relation_id)
			link = link_to name.name, cwe_compound_element_path(name.element_id)
		end
		return link
	end
end
