require 'cucumber_ftc'
require 'ecp_class'
require 'semantic_model'

include CucumberFTC::ECP

class CucumberFTC::ECP::ClassDefinition
	def initialize
		@all_semantic_model_classes = Array.new
	end

	def register_semantic_model semantic_model_class
		raise ArgumentError.new(
			'the second argument MUST be a member of SemanticModel class'
		) if not(semantic_model_class < SemanticModel)

		@all_semantic_model_classes.push(semantic_model_class)
	end

	def define_class class_name, expression
		CucumberFTC::ECP::EcpClass.new(
			class_name,
			create_semantic_model_with_expression_matches(
				expression
			)
		)
	end

	def description_match_any_semantic_model? description
		not get_regex_to(description).nil?
	end

	private
	def get_semantic_model_from expression
		for regex in get_registered_regexes
			return get_semantic_model_for(regex) if regex =~ expression
		end
	end

	def get_semantic_model_for searched_regex
		for semantic_model in @all_semantic_model_classes
			if semantic_model.regex == searched_regex
				return semantic_model
			end
		end
	end

	def create_semantic_model_with_expression_matches expression
		if matches_hasnt_arguments?(expression)
			return get_semantic_model_from(expression).new
		else
			return get_semantic_model_from(expression).new(
				*get_matches_to(expression)	
			)
		end
	end

	def matches_hasnt_arguments? expression
		get_matches_to(expression).size==1
	end

	def get_matches_to expression
		matches =  get_regex_to(expression).match(expression)

		return	matches[1...matches.size]
	end

	def get_regex_to(expression) 
		for regex in get_registered_regexes
			return regex if regex =~expression
		end

		return nil
	end

	def get_registered_regexes 
		@all_semantic_model_classes.map{|semantic|
			semantic.regex
		}
	end
end
