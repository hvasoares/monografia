require File.dirname(__FILE__)+'/cucumber_ftc'
require File.dirname(__FILE__)+'/ecp_class'
class CucumberFTC::ECP::ClassDefinition
	def initialize
		@all_semantic_model_classes = Hash.new
	end

	def register_semantic_model regex,semantic_model_class
		@all_semantic_model_classes[regex]=semantic_model_class

	end

	def define_class class_name, expression
		CucumberFTC::ECP::EcpClass.new(
			class_name,
			create_semantic_model_with_expression_matches(
				expression
			)
		)
	end

	private
	def get_semantic_model_from expression
		for regex in @all_semantic_model_classes.keys
			return @all_semantic_model_classes[regex] if regex =~ expression
		end
	end

	def create_semantic_model_with_expression_matches expression
		matches = get_matches_to expression
		if matches.size == 1 
			return get_semantic_model_from(expression).new
		else
			return get_semantic_model_from(expression).new(
				matches[1...matches.size]
			)
		end
	end

	def get_matches_to expression
		return get_regex_to(expression).match(expression)
	end

	def get_regex_to(expression) 
		for regex in @all_semantic_model_classes.keys
			return regex if regex =~expression
		end
	end
end
