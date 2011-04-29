require 'cucumber_ftc'
require 'variable_definitions'
require 'facade'
require 'integer_range_semantic_model'
include CucumberFTC::ECP
class CucumberFTC::ECP::Configuration
	def facade
		facade =Facade.new(
			VariableDefinitions.new(
				ClassDefinition.new
			)
		)
		
		facade.register_class(
			IntegerRangeSemanticModel
		)

		return facade
	end
end
