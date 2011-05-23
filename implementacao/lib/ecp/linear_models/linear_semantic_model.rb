require File.dirname(__FILE__)+'/module_def'
require File.dirname(__FILE__)+'/../semantic_model'

class CucumberFTC::ECP::LinearModels::LinearSemanticModel < CucumberFTC::ECP::SemanticModel
	def initialize linear_set
		@linear_set =linear_set
	end

	def samples
		[
			@linear_set.first,
			@linear_set.middle,
			@linear_set.last
		]
	end

	def invalid_samples
		@linear_set.invalids
	end
end
