require 'complex_logic_semantic_model'
include CucumberFTC::ECP
class CucumberFTC::ECP::AndSemanticModel < ComplexLogicSemanticModel
	def initialize *semantics
		super(*semantics)
	end
	
	def applies_to? obj
		for semantic in @semantics 
			if not semantic.applies_to?(obj) then
				return false
			end
		end

		return true
	end

	def samples
		result = @semantics.first.samples

		@semantics.each{|semantic|
			if semantic!=@semantics.first then
				result = result & semantic.samples
			end
		}

		return result
	end

end
