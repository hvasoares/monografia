require 'complex_logic_semantic_model'
include CucumberFTC::ECP

class CucumberFTC::ECP::OrSemanticModel < ComplexLogicSemanticModel
	def initialize *semantic_models
		super(*semantic_models)
	end

	def applies_to? obj
		for semantic in @semantics
			if semantic.applies_to? obj then
				return true
			end
		end

		return false
	end

	def samples
		result = []
		@semantics.each{|semantic|
			result.concat(semantic.samples)
		}
		return result
	end
end
