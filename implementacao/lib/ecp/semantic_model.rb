require File.dirname(__FILE__)+'/module_def'

class CucumberFTC::ECP::SemanticModel

	def samples
		fail('should be implemented')
	end

	def applies_to? obj
		fail("should be implemented")
	end
end
