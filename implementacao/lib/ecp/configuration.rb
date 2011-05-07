require File.dirname(__FILE__)+'/module_def'
require File.dirname(__FILE__)+'/variable_definitions'
require File.dirname(__FILE__)+'/facade'
require File.dirname(__FILE__)+'/integer_range_semantic_model'
require File.dirname(__FILE__)+'/double_range_semantic'

include CucumberFTC::ECP
class CucumberFTC::ECP::Configuration
	def facade
		facade =Facade.new(
			VariableDefinitions.new(
				ClassDefinition.new
			)
		)
	
		[IntegerRangeSemanticModel,DoubleRangeSemantic].each{|klass|
			facade.register_class(klass)
		}

		return facade
	end
end
