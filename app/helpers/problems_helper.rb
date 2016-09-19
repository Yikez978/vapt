module ProblemsHelper
	def panel_collapsed(problem_view, problem)
		if problem_view && problem_view.id == problem.id
			'panel-collapse collapse in' 
		else
			'panel-collapse collapse'
		end
	end

	def add_id(string, object)
		"#{string}_#{object.id}"
	end

	def get_hint(hint)
		hint.kind_of?(String) ? Hint.find(hint) : Hint.find(hint.hint_id)
	end

	def get_hints_for_problem(problem)
		problem.hints_array
	end
end
