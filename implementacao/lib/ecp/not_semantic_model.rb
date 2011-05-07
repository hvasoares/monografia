require File.dirname(__FILE__)+'/semantic_model'
include CucumberFTC::ECP
class CucumberFTC::ECP::NotSemanticModel < SemanticModel	
	def initialize semantic_model
		raise ArgumentError.new(
			'the argument MUST be a SemanticModel instance'
		) if not semantic_model.is_a?(SemanticModel)

		@semantic_model = semantic_model
	end

	def applies_to? obj
		not @semantic_model.applies_to?(obj)	
	end
end
