require 'semantic_model'

class CucumberFTC::ECP::ComplexLogicSemanticModel < CucumberFTC::ECP::SemanticModel
	def initialize *semantic_models
		if semantic_models.size < 2 then
			raise ArgumentError.new(
				'you should pass 2 or more semantic models'
			)
		end

		for semantic in semantic_models
			raise ArgumentError.new(
				"the #{semantic_models.index(semantic)+1}-th argument isn't a SemanticModel all arguments MUST be member of SemanticModel class it is #{semantic.class}"
			) if not semantic.is_a?(SemanticModel)
		end

		@semantics = semantic_models
	end
end
