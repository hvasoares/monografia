require 'cucumber_ftc'
require 'no_regex_for_class_name'
require 'class_definition'
include CucumberFTC::ECP
class CucumberFTC::ECP::VariableDefinitions 
	def initialize possible_classes
		raise ArgumentError.new(
			'The argument MUST be a member of CucumberFTC::ECP:ClassDefinition class'
		) if not possible_classes.is_a?(CucumberFTC::ECP::ClassDefinition)

		@variables = Array.new
		@possible_classes = possible_classes
	end

	def register_semantic_model semantic_model
		@possible_classes.register_semantic_model(semantic_model)
	end

	def declare var_name
		@last_declared_variable = var_name
		return self
	end

	def declare_invalid_input variable
	end

	def with_description description
		raise NoRegexForClassName.new(
			description
		) if not @possible_classes.description_match_any_semantic_model?(description)
		@variables.push(
			@possible_classes.define_class(
				@last_declared_variable,
				description
			)
		)
	end

	def get_vars
		@variables.map{|var|
			var.name
		}
	end

	def get_valid_inputs_for var_name
		@variables.select{ |ecp_class|
			ecp_class.name == var_name
		}
	end

end
