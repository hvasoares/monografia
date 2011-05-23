require File.dirname(__FILE__)+'/module_def'
require File.dirname(__FILE__)+'/linear_semantic_model'
class CucumberFTC::ECP::LinearModels::IntegerSet < CucumberFTC::ECP::LinearModels::LinearSemanticModel
	def initialize range
		@range = range
	end

	def samples
		[
			@range.begin,
			@range.end,
			@range.begin+1,
			@range.end-1,
			elem_from_middle
		]
	end

	def elem_from_middle
		diff = @range.end - 1 - @range.begin
		return @range.begin+1 +rand(diff)
	end

	def invalid_samples
		[@range.begin - 1, @range.end + 1 ]
	end

	def applies_to? integer
		@range.include?(integer)
	end

end
