require 'cucumber_ftc'
require 'no_regex_for_class_name'
require 'variable_definitions'
require 'semantic_model'
require 'test_case_generator'
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

	def generate_tests
		TestCaseGenerator.new(@variable_definitions).generate
	end

end
