require File.dirname(__FILE__)+'/module_def'
require File.dirname(__FILE__)+'/variable_definitions'
include CucumberFTC::ECP

class CucumberFTC::ECP::Facade
	def initialize variable_definitions
		raise ArgumentError.new(
		'The argument MUST be a member of CucumberFTC::ECP::VariableDefinitions'
		) if not variable_definitions.is_a?(VariableDefinitions)
		@variable_definitions = variable_definitions
	end

	def register_class semantic_model
		@variable_definitions.register_semantic_model(
			semantic_model
			)
	end

	def register_variable variable, description
		@variable_definitions.declare(variable)
		@variable_definitions.with_description(description)
	end

	def declare_invalid_variable variable,description
		@variable_definitions.declare_invalid_input(variable)
		@variable_definitions.with_description(description)
	end
	
	def get_all_valid_inputs
		@variable_definitions.get_all_valid_inputs
	end
end
