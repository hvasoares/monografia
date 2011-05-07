require File.dirname(__FILE__)+'/module_def'
require File.dirname(__FILE__)+'/variable_definitions'
require File.dirname(__FILE__)+'/facade'
require File.dirname(__FILE__)+'/integer_range_semantic_model'
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
